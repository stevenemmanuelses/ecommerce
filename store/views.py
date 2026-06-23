import json
import uuid
import hashlib
from decimal import Decimal

from django.http import HttpResponse, JsonResponse
from django.views.decorators.csrf import csrf_exempt, ensure_csrf_cookie
from django.conf import settings
from django.shortcuts import render, get_object_or_404, redirect
from django.contrib.auth import authenticate, login, logout
from django.contrib.auth.decorators import login_required
from django.contrib.admin.views.decorators import staff_member_required
from django.db import transaction
from django.db.models import Max, Q
from django.views.decorators.cache import never_cache
from .forms import ProductForm, CustomUserCreationForm, CheckoutAddressForm, AccountProfileForm
from .models import Product, CartItem, Category, Order, ReturnRequest, UserProfile, OrderItem, ProductReview

def get_session_key(request):
    session_key = request.session.session_key
    if not session_key:
        request.session.save()
        session_key = request.session.session_key
    return session_key


def get_cart_items(request):
    if request.user.is_authenticated:
        return CartItem.objects.filter(user=request.user)
    return CartItem.objects.filter(session_key=get_session_key(request))


def get_shipping_cost(profile):
    if not profile:
        return 0

    regency = (profile.regency or '').strip().lower()
    province = (profile.province or '').strip().lower()

    if 'purwokerto' in regency:
        return 10000
    if province == 'jawa tengah':
        return 15000
    if province in ['d.i. yogyakarta', 'diyogyakarta', 'di yogyakarta', 'daerah istimewa yogyakarta', 'yogyakarta']:
        return 18000
    if province == 'jawa barat':
        return 22000
    if province == 'banten':
        return 25000
    if province == 'dki jakarta':
        return 30000
    if province == 'jawa timur':
        return 25000
    if province in ['bali', 'nusa tenggara barat', 'ntb', 'nusa tenggara timur', 'ntt']:
        return 45000
    if any(key in province for key in ['sumatera', 'riau', 'jambi', 'lampung', 'bengkulu', 'bangka belitung', 'kepulauan riau']):
        return 60000
    if 'kalimantan' in province:
        return 70000
    if 'sulawesi' in province or province == 'gorontalo':
        return 70000
    if 'maluku' in province or 'papua' in province:
        return 90000
    return 80000


def get_shipping_cost_by_courier(profile, courier):
    base_cost = get_shipping_cost(profile)
    if not base_cost or base_cost == 0:
        return 0
    if courier == 'pos':
        return max(8000, base_cost - 2000)
    elif courier == 'tiki':
        return base_cost + 1500
    else: # jne
        return base_cost


def generate_unique_code_for_next_order():
    next_id = (Order.objects.aggregate(max_id=Max('id'))['max_id'] or 0) + 1
    return int(str(next_id).zfill(3)[-3:])


def _to_integer_amount(amount):
    return int(Decimal(amount).quantize(Decimal('1')))


def _apply_short_session_expiry(request):
    request.session.set_expiry(900)





def get_stock_warnings(cart_items):
    warnings = []
    for item in cart_items.select_related('product'):
        stock = item.product.stock
        if item.quantity > stock:
            if stock > 0:
                warnings.append({
                    'message': f"Stok untuk {item.product.name} hanya tersedia {stock} unit. Mohon kurangi jumlah pembelian.",
                    'available': stock,
                })
            else:
                warnings.append({
                    'message': f"Stok untuk {item.product.name} habis. Harap hapus produk ini dari keranjang.",
                    'available': stock,
                })
    return warnings


def transfer_session_cart_to_user(request):
    if not request.user.is_authenticated:
        return
    session_key = request.session.session_key
    if not session_key:
        return

    session_items = CartItem.objects.filter(session_key=session_key)
    for item in session_items:
        existing_item, created = CartItem.objects.get_or_create(
            user=request.user,
            product=item.product,
            defaults={'quantity': item.quantity}
        )
        if not created:
            existing_item.quantity += item.quantity
            existing_item.save()
    session_items.delete()


def landing_view(request):
    products = Product.objects.all()
    return render(request, 'landing.html', {'products': products})


def search_view(request):
    query = request.GET.get('q', '').strip()
    products = Product.objects.all()
    if query:
        products = products.filter(
            Q(name__icontains=query) | Q(description__icontains=query)
        )
    return render(request, 'search_results.html', {'products': products, 'query': query})


def logout_view(request):
    logout(request)
    return redirect('store:landing')


def register_view(request):
    if request.user.is_authenticated:
        return redirect('store:dashboard')
    form = CustomUserCreationForm()
    if request.method == 'POST':
        form = CustomUserCreationForm(request.POST)
        if form.is_valid():
            user = form.save()
            raw_password = form.cleaned_data.get('password1')
            user = authenticate(request, username=user.username, password=raw_password)
            if user is not None:
                login(request, user)
                _apply_short_session_expiry(request)
                transfer_session_cart_to_user(request)
            return redirect('store:dashboard')
    return render(request, 'register.html', {'form': form})


@login_required
def account_view(request):
    profile = getattr(request.user, 'profile', None)
    if not profile:
        profile = UserProfile(user=request.user)

    success_message = None
    if request.method == 'POST':
        form = AccountProfileForm(request.POST, instance=profile, user=request.user)
        if form.is_valid():
            form.save()
            success_message = 'Data akun berhasil diperbarui.'
    else:
        form = AccountProfileForm(instance=profile, user=request.user)

    user_orders = list(Order.objects.filter(user=request.user).order_by('created_at'))
    for index, order in enumerate(user_orders, start=1):
        order.user_order_number = index
    orders = list(reversed(user_orders))

    return render(request, 'account.html', {
        'form': form,
        'orders': orders,
        'success_message': success_message,
    })


@login_required
def dashboard(request):
    products = Product.objects.all()[:12]
    return render(request, 'home.html', {'products': products})


@staff_member_required
def product_create(request):
    if request.method == 'POST':
        form = ProductForm(request.POST, request.FILES)
        if form.is_valid():
            form.save()
            return redirect('store:dashboard')
    else:
        form = ProductForm()
    return render(request, 'product_form.html', {'form': form, 'title': 'Tambah Produk'})


@staff_member_required
def product_edit(request, slug):
    product = get_object_or_404(Product, slug=slug)
    if request.method == 'POST':
        if request.POST.get('delete_product'):
            product.delete()
            return redirect('store:dashboard')
        form = ProductForm(request.POST, request.FILES, instance=product)
        if form.is_valid():
            form.save()
            return redirect('store:dashboard')
    else:
        form = ProductForm(instance=product)
    return render(request, 'product_form.html', {'form': form, 'title': 'Edit Produk'})


@login_required
def add_to_cart(request, slug):
    product = get_object_or_404(Product, slug=slug)
    item, created = CartItem.objects.get_or_create(
        user=request.user,
        product=product,
        defaults={'quantity': 1}
    )
    if not created:
        item.quantity += 1
        item.save()
    
    referer = request.META.get('HTTP_REFERER')
    if referer and 'login' not in referer and 'register' not in referer:
        return redirect(referer)
    return redirect('store:cart')


def cart_view(request):
    cart_items = get_cart_items(request)
    total = sum(item.product.price * item.quantity for item in cart_items)
    return render(request, 'cart.html', {'cart_items': cart_items, 'cart_total': total})


@login_required
@ensure_csrf_cookie
@never_cache
def checkout_view(request):
    cart_items = get_cart_items(request)
    if not cart_items.exists():
        return redirect('store:cart')

    profile = getattr(request.user, 'profile', None)
    form = CheckoutAddressForm(instance=profile)
    form_saved = False

    if request.method == 'POST':
        form = CheckoutAddressForm(request.POST, instance=profile)
        if form.is_valid():
            profile = form.save(commit=False)
            profile.user = request.user
            profile.save()
            form_saved = True

    stock_warnings = get_stock_warnings(cart_items)
    subtotal = sum(item.product.price * item.quantity for item in cart_items)
    
    courier = request.session.get('selected_courier', 'jne')
    shipping_cost = get_shipping_cost_by_courier(profile, courier)
    
    unique_code = generate_unique_code_for_next_order()
    return render(request, 'checkout.html', {
        'cart_items': cart_items,
        'cart_total': subtotal,
        'shipping_cost': shipping_cost,
        'profile': profile,
        'order_total': subtotal + shipping_cost,
        'unique_code': unique_code,
        'estimated_total_with_code': subtotal + shipping_cost + unique_code,
        'form': form,
        'form_saved': form_saved,
        'stock_warnings': stock_warnings,
        'couriers': Order.COURIER_CHOICES,
        'selected_courier': courier,
        'payment_methods': Order.PAYMENT_METHOD_CHOICES,
        'selected_payment_method': request.session.get('selected_payment_method', 'qris'),
    })


@login_required
@ensure_csrf_cookie
@never_cache
@login_required
def payment_view(request):
    if request.method != 'POST':
        return redirect('store:cart')
    
    cart_items = get_cart_items(request)
    if not cart_items.exists():
        return redirect('store:cart')
    
    courier = request.POST.get('courier', 'jne')
    payment_method_key = request.POST.get('payment_method', 'qris')
    
    # Store selections in session
    request.session['selected_courier'] = courier
    request.session['selected_payment_method'] = payment_method_key
    
    profile = getattr(request.user, 'profile', None)
    shipping_cost = _to_integer_amount(get_shipping_cost_by_courier(profile, courier))
    subtotal = _to_integer_amount(sum(item.product.price * item.quantity for item in cart_items))
    available_points = profile.store_points if profile else 0
    
    # Check points_to_use
    points_to_use = int(request.session.get('points_to_use', 0) or 0)
    points_to_use = min(points_to_use, available_points, subtotal + shipping_cost)
    
    points_discount = points_to_use
    order_total = subtotal + shipping_cost - points_discount
    
    with transaction.atomic():
        order = Order.objects.create(
            user=request.user,
            paid=False,
            shipping_cost=shipping_cost,
            total_price=order_total,
            points_used=points_to_use,
            status='pending_payment',
            courier=courier,
            payment_method=payment_method_key
        )
        for item in cart_items.select_related('product'):
            OrderItem.objects.create(
                order=order,
                product=item.product,
                quantity=item.quantity,
                price=item.product.price,
            )
        # Clear the cart items immediately
        CartItem.objects.filter(user=request.user).delete()
        
    # Reset points session
    request.session['points_to_use'] = 0
    
    return redirect('store:order_payment', order_id=order.id)


@login_required
def order_payment_view(request, order_id):
    order = get_object_or_404(Order, id=order_id, user=request.user)
    
    # Allow upload only if order is unpaid and not cancelled/verified
    if order.paid or order.status not in ['pending_payment', 'payment_verification']:
        return redirect('store:order_tracking', order_id=order.id)
    
    error = None
    if request.method == 'POST':
        payment_proof = request.FILES.get('payment_proof')
        if not payment_proof:
            error = 'Silakan pilih file bukti transfer terlebih dahulu.'
        else:
            # Size validation: 50 KB max
            # 50 KB = 50 * 1024 = 51200 bytes
            if payment_proof.size > 50 * 1024:
                error = f'Ukuran file bukti transfer terlalu besar ({payment_proof.size / 1024:.1f} KB). Maksimal adalah 50 KB.'
            else:
                content_type = getattr(payment_proof, 'content_type', '')
                if not content_type.startswith('image/'):
                    error = 'Format file tidak didukung. Harap unggah file gambar (JPG, JPEG, PNG, atau GIF).'
                else:
                    order.payment_proof = payment_proof
                    order.status = 'payment_verification'
                    order.save()
                    return render(request, 'payment_success_manual.html', {'order': order})
                    
    context = {
        'order': order,
        'error': error,
        'billing_total': order.total_price + order.unique_code,
    }
    return render(request, 'payment_manual.html', context)


def login_view(request):
    next_page = request.POST.get('next') or request.GET.get('next')
    if request.user.is_authenticated:
        return redirect(next_page or 'store:dashboard')
    error = None
    if request.method == 'POST':
        username = request.POST.get('username')
        password = request.POST.get('password')
        user = authenticate(request, username=username, password=password)
        if user is not None:
            login(request, user)
            _apply_short_session_expiry(request)
            transfer_session_cart_to_user(request)
            return redirect(next_page or 'store:dashboard')
        else:
            error = 'Nama pengguna atau kata sandi salah.'
    return render(request, 'login.html', {'error': error, 'next': next_page})


@login_required
def order_tracking_view(request, order_id):
    order = get_object_or_404(Order, id=order_id, user=request.user)
    return render(request, 'order_tracking.html', {'order': order})


@login_required
def order_review_view(request, order_id):
    order = get_object_or_404(Order, id=order_id, user=request.user)
    order_items = order.items.select_related('product').all()
    review_message = None
    error = None

    # Redirect if order is not delivered yet
    if order.status != 'delivered':
        return redirect('store:order_tracking', order_id=order.id)

    if request.method == 'POST' and order.status == 'delivered':
        item_id = request.POST.get('item_id')
        rating = request.POST.get('rating')
        comment = request.POST.get('comment', '').strip()
        if item_id and rating:
            try:
                order_item = order_items.get(id=item_id)
            except OrderItem.DoesNotExist:
                error = 'Item tidak ditemukan dalam pesanan ini.'
            else:
                # Check if review already exists — only allow one review per item
                if hasattr(order_item, 'review'):
                    try:
                        _ = order_item.review
                        error = 'Anda sudah memberikan review untuk produk ini. Review hanya dapat diberikan satu kali.'
                    except ProductReview.DoesNotExist:
                        pass

                if not error:
                    try:
                        rating_value = min(max(int(rating), 1), 5)
                    except (ValueError, TypeError):
                        rating_value = 5

                    ProductReview.objects.create(
                        order_item=order_item,
                        user=request.user,
                        product=order_item.product,
                        rating=rating_value,
                        comment=comment,
                    )
                    review_message = 'Review berhasil disimpan. Terima kasih atas ulasan Anda!'
    elif request.method == 'POST' and order.status != 'delivered':
        error = 'Pesanan harus sudah diterima sebelum memberikan review.'

    # Re-fetch to include new reviews
    order_items = order.items.select_related('product').all()

    return render(request, 'order_review.html', {
        'order': order,
        'order_items': order_items,
        'review_message': review_message,
        'error': error,
        'rating_choices': [1, 2, 3, 4, 5],
    })


@staff_member_required
def return_review(request):
    return_requests = ReturnRequest.objects.select_related('order', 'user').order_by('-created_at')
    return render(request, 'return_review.html', {'return_requests': return_requests})


@staff_member_required
def return_review_action(request, return_id):
    return_request = get_object_or_404(ReturnRequest, id=return_id)
    if request.method == 'POST':
        action = request.POST.get('action')
        if action in ['pending', 'approved', 'rejected']:
            previous_status = return_request.status
            return_request.status = action
            return_request.save()
            if action == 'approved' and previous_status != 'approved':
                return_request.award_points_if_approved()
    return redirect('store:return_review')


@staff_member_required
def order_management_view(request):
    orders = Order.objects.select_related('user').prefetch_related('items__product').order_by('-created_at')
    return render(request, 'order_management.html', {'orders': orders})


@staff_member_required
def update_order_status(request, order_id):
    order = get_object_or_404(Order, id=order_id)
    if request.method == 'POST':
        status = request.POST.get('status')
        tracking_number = request.POST.get('tracking_number', '').strip()

        # Save tracking number if provided
        if tracking_number:
            order.tracking_number = tracking_number

        if status in dict(Order.STATUS_CHOICES):
            if status in ['processing', 'shipped', 'delivered'] and not order.paid:
                with transaction.atomic():
                    order = Order.objects.select_for_update().get(id=order_id)
                    if not order.paid:
                        if order.points_used > 0:
                            profile = getattr(order.user, 'profile', None)
                            if profile:
                                profile.store_points = max(0, profile.store_points - order.points_used)
                                profile.save(update_fields=['store_points'])
                        
                        order.paid = True
                        
                        # Decrement stock
                        for item in order.items.all():
                            if item.product:
                                item.product.stock = max(0, item.product.stock - item.quantity)
                                item.product.save()
            
            order.status = status
            # Re-apply tracking number after potential select_for_update refresh
            if tracking_number:
                order.tracking_number = tracking_number
            order.save()
    return redirect('store:order_management')


@login_required
def return_request_view(request, order_id):
    order = get_object_or_404(Order, id=order_id, user=request.user)
    if not order.paid:
        return redirect('store:dashboard')

    existing_request = ReturnRequest.objects.filter(order=order).order_by('-created_at').first()
    error = None
    success = None
    reason = ''

    if existing_request:
        reason = existing_request.reason

    if request.method == 'POST':
        if existing_request:
            error = 'Anda sudah mengajukan retur untuk pesanan ini. Silakan tunggu hasil review admin.'
        else:
            reason = request.POST.get('reason', '').strip()
            agree = request.POST.get('agree_terms') == 'on'
            if not agree:
                error = 'Anda harus menyetujui syarat dan ketentuan retur.'
            elif not reason:
                error = 'Silakan jelaskan alasan retur Anda.'
            else:
                existing_request = ReturnRequest.objects.create(
                    order=order,
                    user=request.user,
                    reason=reason,
                    accepted_terms=agree,
                )
                success = 'Permintaan retur Anda telah dikirim. Tim kami akan memprosesnya segera.'

    return render(request, 'return_request.html', {
        'order': order,
        'error': error,
        'success': success,
        'reason': reason,
        'return_request': existing_request,
    })


def update_cart(request):
    if request.method == 'POST':
        item_id = request.POST.get('item_id')
        quantity = int(request.POST.get('quantity', 1))
        cart_items = get_cart_items(request)
        item = get_object_or_404(cart_items, id=item_id)
        if quantity > 0:
            item.quantity = quantity
            item.save()
        else:
            item.delete()
    return redirect('store:cart')


def remove_from_cart(request, item_id):
    cart_items = get_cart_items(request)
    item = get_object_or_404(cart_items, id=item_id)
    item.delete()
    return redirect('store:cart')


def product_detail(request, slug):
    product = get_object_or_404(Product, slug=slug)
    
    has_purchased = False
    user_order_item = None
    existing_user_review = None
    
    if request.user.is_authenticated:
        user_order_item = OrderItem.objects.filter(
            order__user=request.user,
            order__status='delivered',
            product=product
        ).first()
        if user_order_item:
            has_purchased = True
            existing_user_review = ProductReview.objects.filter(order_item=user_order_item).first()

    if request.method == 'POST' and has_purchased:
        rating = request.POST.get('rating')
        comment = request.POST.get('comment', '').strip()
        if rating:
            try:
                rating_value = min(max(int(rating), 1), 5)
            except (ValueError, TypeError):
                rating_value = 5
            
            review, created = ProductReview.objects.get_or_create(
                order_item=user_order_item,
                defaults={
                    'user': request.user,
                    'product': product,
                    'rating': rating_value,
                    'comment': comment,
                }
            )
            if not created:
                review.rating = rating_value
                review.comment = comment
                review.save(update_fields=['rating', 'comment'])
                
            return redirect('store:product_detail', slug=product.slug)

    reviews = ProductReview.objects.filter(product=product).select_related('user').order_by('-created_at')
    
    context = {
        'product': product,
        'reviews': reviews,
        'has_purchased': has_purchased,
        'existing_user_review': existing_user_review,
    }
    return render(request, 'product_detail.html', context)


def category_view(request, slug):
    category = get_object_or_404(Category, slug=slug)
    products = Product.objects.filter(category=category)
    return render(request, 'landing.html', {'products': products, 'active_category': category})


@login_required
def download_invoice(request, order_id):
    from django.http import HttpResponse
    from .invoice_generator import generate_invoice_pdf
    
    order = get_object_or_404(Order, id=order_id, user=request.user)
    try:
        pdf_content = generate_invoice_pdf(order)
        response = HttpResponse(pdf_content, content_type='application/pdf')
        response['Content-Disposition'] = f'attachment; filename="invoice_{order.tracking_code}.pdf"'
        return response
    except Exception as e:
        return HttpResponse(f"Gagal membuat PDF Invoice: {str(e)}", status=500)


@login_required
def cancel_order(request, order_id):
    order = get_object_or_404(Order, id=order_id, user=request.user)
    if not order.paid and order.status == 'pending_payment':
        order.status = 'cancelled'
        order.save()
    return redirect('store:account')
