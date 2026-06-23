import django, os
os.environ['DJANGO_SETTINGS_MODULE'] = 'variety.settings'
django.setup()
from django.conf import settings
settings.ALLOWED_HOSTS = ['*']
settings.DEBUG = True
from django.test import Client
from django.contrib.auth.models import User
from store.models import Order, ReturnRequest, UserProfile, Product, CartItem
from django.db import transaction
# Setup
user = User.objects.filter(is_staff=False).first()
if not user:
    user = User.objects.create_user(username='testbuyer', password='password')
profile, created = UserProfile.objects.get_or_create(user=user)
profile.store_points = 50000
profile.save()
# Clean up orders
Order.objects.filter(user=user).delete()
print(f"Initial store points: {profile.store_points}")
# 1. Test immediate deduction at checkout creation
client = Client()
client.force_login(user)
product = Product.objects.first()
if not product:
    product = Product.objects.create(name='Test Product', price=100000, slug='test-product', stock=10)
CartItem.objects.filter(user=user).delete()
CartItem.objects.create(user=user, product=product, quantity=1)
print("Cart item created.")
# Post to payment to create order using 20000 points
resp = client.post('/cart/payment/', {
    'courier': 'jne',
    'payment_method': 'bank_transfer',
    'points_to_use': 20000
})
print(f"POST Response status: {resp.status_code}")
if resp.status_code != 302:
    print("POST failed! Content:")
    print(resp.content.decode()[:1000])
    exit()
profile.refresh_from_db()
print(f"Store points after checkout: {profile.store_points} (Expected: 30000)")
order = Order.objects.filter(user=user).order_by('-created_at').first()
if not order:
    print("No order created!")
    exit()
print(f"Created Order #{order.id}, total_price={order.total_price}, points_used={order.points_used}, points_refunded={order.points_refunded}")
# 2. Test refund on user cancellation
client.post(f'/orders/{order.id}/cancel/')
profile.refresh_from_db()
order.refresh_from_db()
print(f"Store points after cancel: {profile.store_points} (Expected: 50000)")
print(f"Order #{order.id} status={order.status}, points_refunded={order.points_refunded} (Expected: True)")
# 3. Create another order using 15000 points to test admin processing / no double deduction
CartItem.objects.create(user=user, product=product, quantity=1)
resp2 = client.post('/cart/payment/', {
    'courier': 'jne',
    'payment_method': 'bank_transfer',
    'points_to_use': 15000
})
print(f"POST 2 Response status: {resp2.status_code}")
profile.refresh_from_db()
print(f"Store points after 2nd checkout: {profile.store_points} (Expected: 35000)")
order2 = Order.objects.filter(user=user).order_by('-created_at').first()
# Admin marks order as processing
admin_client = Client()
admin = User.objects.filter(is_staff=True).first()
if not admin:
    admin = User.objects.create_superuser(username='admin2', password='password', email='admin2@example.com')
admin_client.force_login(admin)
admin_client.post(f'/orders/{order2.id}/update-status/', {
    'status': 'processing',
    'tracking_number': '123456789'
})
profile.refresh_from_db()
order2.refresh_from_db()
print(f"Store points after admin processing: {profile.store_points} (Expected: 35000 - i.e. no double deduction!)")
print(f"Order #{order2.id} status={order2.status}, paid={order2.paid}")
# Clean up
if order:
    order.delete()
if order2:
    order2.delete()