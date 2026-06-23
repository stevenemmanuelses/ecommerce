from django.db import models
from django.contrib.auth import get_user_model

User = get_user_model()

class Category(models.Model):
    name = models.CharField(max_length=100)
    slug = models.SlugField(unique=True)

    def __str__(self):
        return self.name

class Product(models.Model):
    category = models.ForeignKey(Category, on_delete=models.SET_NULL, null=True, blank=True)
    name = models.CharField(max_length=200)
    slug = models.SlugField(unique=True)
    description = models.TextField(blank=True)
    price = models.DecimalField(max_digits=10, decimal_places=2)
    stock = models.PositiveIntegerField(default=0)
    image = models.ImageField(upload_to='product_images/', blank=True, null=True)
    image_url = models.CharField(max_length=200, blank=True)
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.name

    def price_idr(self):
        return f"Rp {int(self.price):,}".replace(',', '.')

    def short_description(self):
        return self.description[:120] + ('...' if len(self.description) > 120 else '')

    def has_image(self):
        return bool(self.image or self.image_url)

class Order(models.Model):
    STATUS_CHOICES = [
        ('pending_payment', 'Menunggu Pembayaran'),
        ('payment_verification', 'Menunggu Verifikasi Pembayaran'),
        ('processing', 'Diproses'),
        ('shipped', 'Dikirim'),
        ('delivered', 'Terkirim'),
        ('cancelled', 'Dibatalkan'),
    ]

    COURIER_CHOICES = [
        ('jne', 'JNE (Reguler)'),
        ('pos', 'POS Indonesia'),
        ('tiki', 'TIKI (Reguler)'),
    ]

    PAYMENT_METHOD_CHOICES = [
        ('qris', 'QRIS'),
        ('bank_transfer', 'Virtual Account (Transfer Bank)'),
        ('e_wallet', 'E-Wallet (GoPay/ShopeePay)'),
    ]

    user = models.ForeignKey(User, on_delete=models.CASCADE)
    created_at = models.DateTimeField(auto_now_add=True)
    paid = models.BooleanField(default=False)
    shipping_cost = models.DecimalField(max_digits=10, decimal_places=2, default=0)
    total_price = models.DecimalField(max_digits=10, decimal_places=2, default=0)
    points_used = models.PositiveIntegerField(default=0)
    status = models.CharField(max_length=20, choices=STATUS_CHOICES, default='pending_payment')
    courier = models.CharField(max_length=20, choices=COURIER_CHOICES, default='jne')
    payment_method = models.CharField(max_length=30, choices=PAYMENT_METHOD_CHOICES, default='qris')
    payment_proof = models.ImageField(upload_to='payment_proofs/', blank=True, null=True)
    tracking_number = models.CharField(max_length=100, blank=True, null=True, verbose_name='Nomor Resi')

    def __str__(self):
        return f"Order #{self.id} - {self.user.username}"

    @property
    def tracking_code(self):
        return f"TRK{self.id:06d}"

    @property
    def unique_code(self):
        return int(str(self.id).zfill(3)[-3:]) if self.id else 0

    @property
    def unique_code_str(self):
        return str(self.unique_code).zfill(3)

    @property
    def total_price_with_code(self):
        from decimal import Decimal
        return self.total_price + Decimal(self.unique_code)

    @property
    def payment_status_display(self):
        if self.paid:
            return "Sudah Dibayar"
        elif self.status == 'payment_verification':
            return "Menunggu Verifikasi"
        elif self.status == 'cancelled':
            return "Dibatalkan"
        else:
            return "Menunggu Pembayaran"

    def get_status_steps(self):
        if self.status == 'cancelled':
            return [
                {'key': 'pending_payment', 'label': 'Pesanan Dibuat', 'active': True},
                {'key': 'cancelled', 'label': 'Dibatalkan', 'active': True},
            ]
        
        is_verification = self.status in ['payment_verification', 'processing', 'shipped', 'delivered'] or self.paid
        is_processing = self.status in ['processing', 'shipped', 'delivered'] or self.paid
        is_shipped = self.status in ['shipped', 'delivered']
        is_delivered = self.status == 'delivered'

        steps = [
            {'key': 'pending_payment', 'label': 'Menunggu Pembayaran', 'active': True},
            {'key': 'payment_verification', 'label': 'Menunggu Verifikasi', 'active': is_verification},
            {'key': 'processing', 'label': 'Sedang Diproses', 'active': is_processing},
            {'key': 'shipped', 'label': 'Sedang Dikirim', 'active': is_shipped},
            {'key': 'delivered', 'label': 'Terkirim', 'active': is_delivered},
        ]
        return steps

class OrderItem(models.Model):
    order = models.ForeignKey('Order', on_delete=models.CASCADE, related_name='items')
    product = models.ForeignKey(Product, on_delete=models.SET_NULL, null=True, blank=True)
    quantity = models.PositiveIntegerField(default=1)
    price = models.DecimalField(max_digits=10, decimal_places=2, default=0)

    def __str__(self):
        return f"{self.product.name if self.product else 'Produk hilang'} x {self.quantity}"

    def total_price(self):
        return self.price * self.quantity

class ProductReview(models.Model):
    order_item = models.OneToOneField(OrderItem, on_delete=models.CASCADE, related_name='review')
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    product = models.ForeignKey(Product, on_delete=models.SET_NULL, null=True, blank=True)
    rating = models.PositiveSmallIntegerField(default=5)
    comment = models.TextField(blank=True)
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"Review untuk {self.product.name if self.product else 'Produk tidak ditemukan'}"

class ReturnRequest(models.Model):
    STATUS_CHOICES = [
        ('pending', 'Pending'),
        ('approved', 'Approved'),
        ('rejected', 'Rejected'),
    ]

    order = models.ForeignKey(Order, on_delete=models.CASCADE)
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    reason = models.TextField(blank=True)
    status = models.CharField(max_length=20, choices=STATUS_CHOICES, default='pending')
    accepted_terms = models.BooleanField(default=False)
    points_amount = models.PositiveIntegerField(default=0)
    points_awarded = models.BooleanField(default=False)
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"Return #{self.id} for Order #{self.order.id}"

    def award_points_if_approved(self):
        if self.status != 'approved' or self.points_awarded:
            return 0

        profile = getattr(self.user, 'profile', None)
        if not profile:
            return 0

        points = self.points_amount or int(self.order.total_price or 0)
        if points <= 0:
            return 0

        profile.store_points += points
        profile.save(update_fields=['store_points'])
        self.points_awarded = True
        self.save(update_fields=['points_awarded'])
        return points

class UserProfile(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE, related_name='profile')
    phone_number = models.CharField(max_length=20, blank=True)
    address_line = models.TextField(blank=True)
    province = models.CharField(max_length=100, blank=True)
    regency = models.CharField(max_length=100, blank=True)
    postal_code = models.CharField(max_length=20, blank=True)
    store_points = models.PositiveIntegerField(default=0)
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"Profil {self.user.username}"

class CartItem(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE, null=True, blank=True)
    product = models.ForeignKey(Product, on_delete=models.CASCADE)
    quantity = models.PositiveIntegerField(default=1)
    session_key = models.CharField(max_length=40, null=True, blank=True)

    class Meta:
        constraints = [
            models.UniqueConstraint(fields=['user', 'product'], name='unique_user_product'),
            models.UniqueConstraint(fields=['session_key', 'product'], name='unique_session_product'),
        ]

    def total_price(self):
        return self.product.price * self.quantity
