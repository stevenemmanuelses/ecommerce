import os
import sys
import django

BASE_DIR = os.path.abspath(os.path.join(os.path.dirname(__file__), '..'))
if BASE_DIR not in sys.path:
    sys.path.insert(0, BASE_DIR)

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'variety.settings')
django.setup()

from store.models import Product

# List of local image paths to assign to products
images = [
    '/static/img/img1.jpg',
    '/static/img/img2.jpg',
    '/static/img/img3.jpg',
    '/static/img/img4.jpg',
]

# Get all products and assign images (cycling through available images)
products = Product.objects.all().order_by('id')
for idx, product in enumerate(products):
    image_url = images[idx % len(images)]
    product.image_url = image_url
    product.save()
    print(f"Updated '{product.name}' with image: {image_url}")

print('Done - all products updated with local images.')
