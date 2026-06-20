import os
import django

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'variety.settings')
django.setup()

from store.models import Order, OrderItem

try:
    order = Order.objects.get(id=20)
    print(f'Order 20 status: {order.status}')
    print(f'Items count: {order.items.count()}')
    items = order.items.all()
    for item in items:
        print(f'  - {item}')
except Order.DoesNotExist:
    print('Order 20 does not exist')
