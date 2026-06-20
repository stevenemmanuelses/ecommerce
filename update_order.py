import os
import django

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'variety.settings')
django.setup()

from store.models import Order

try:
    order = Order.objects.get(id=20)
    print(f'Current status: {order.status}')
    order.status = 'delivered'
    order.save()
    print(f'Updated status: {order.status}')
    print(f'Order items: {order.items.count()}')
except Order.DoesNotExist:
    print('Order 20 does not exist')
except Exception as e:
    print(f'Error: {e}')
