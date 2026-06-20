#!/usr/bin/env python
import os
import sys
import django

# Setup Django
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'variety.settings')
sys.path.insert(0, str(__import__('pathlib').Path(__file__).resolve().parent))
django.setup()

from store.models import Order, OrderItem, Product

# Check Order 20
try:
    order = Order.objects.get(id=20)
    print(f'Order 20 found')
    print(f'  Status: {order.status}')
    print(f'  Items count: {order.items.count()}')
    
    if order.items.count() == 0:
        print('  No items found. Creating sample items...')
        products = Product.objects.all()[:2]
        for i, product in enumerate(products):
            item = OrderItem.objects.create(
                order=order,
                product=product,
                quantity=1,
                price=product.price
            )
            print(f'  Created item: {item}')
        
        # Update order status
        order.status = 'delivered'
        order.save()
        print(f'  Updated order status to: delivered')
    else:
        # Just update status
        order.status = 'delivered'
        order.save()
        print(f'  Updated order status to: delivered')
        
except Order.DoesNotExist:
    print('Order 20 does not exist. Creating test order...')
    from django.contrib.auth import get_user_model
    User = get_user_model()
    
    users = User.objects.all()
    if users.exists():
        user = users.first()
        order = Order.objects.create(
            user=user,
            status='delivered',
            paid=True,
            shipping_cost=10000,
            total_price=50000,
            points_used=0
        )
        
        # Create items for this order
        products = Product.objects.all()[:2]
        for product in products:
            OrderItem.objects.create(
                order=order,
                product=product,
                quantity=1,
                price=product.price
            )
        print(f'Created order {order.id} with items')
    else:
        print('No users found in database')

print('Done!')
