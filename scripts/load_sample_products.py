import os
import sys
import django

BASE_DIR = os.path.abspath(os.path.join(os.path.dirname(__file__), '..'))
if BASE_DIR not in sys.path:
    sys.path.insert(0, BASE_DIR)

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'variety.settings')
django.setup()

from store.models import Category, Product

products = [
    {
        'name': 'Parfum Mawar Premium',
        'slug': 'parfum-mawar-premium',
        'description': 'Aroma mewah dengan sentuhan mawar merah dan vanila, cocok untuk acara spesial.',
        'price': 450000,
        'stock': 12,
        'image_url': 'https://images.unsplash.com/photo-1513708923786-6c8b53440746?auto=format&fit=crop&w=800&q=80',
    },
    {
        'name': 'Eau de Cologne Citrus',
        'slug': 'eau-de-cologne-citrus',
        'description': 'Kesegaran citrus yang ringan dan energik untuk aktivitas sehari-hari.',
        'price': 275000,
        'stock': 20,
        'image_url': 'https://images.unsplash.com/photo-1512436991641-6745cdb1723f?auto=format&fit=crop&w=800&q=80',
    },
    {
        'name': 'Musk Floral Elegance',
        'slug': 'musk-floral-elegance',
        'description': 'Kombinasi musk lembut dan bunga putih menciptakan kesan elegan dan tahan lama.',
        'price': 520000,
        'stock': 8,
        'image_url': 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?auto=format&fit=crop&w=800&q=80',
    },
    {
        'name': 'Amber Wood Signature',
        'slug': 'amber-wood-signature',
        'description': 'Wewangian hangat dengan kayu amber dan cendana, cocok untuk suasana malam.',
        'price': 610000,
        'stock': 10,
        'image_url': 'https://images.unsplash.com/photo-1503341455253-b2e723bb3dbb?auto=format&fit=crop&w=800&q=80',
    },
]

for item in products:
    product, created = Product.objects.get_or_create(
        slug=item['slug'],
        defaults={
            'name': item['name'],
            'description': item['description'],
            'price': item['price'],
            'stock': item['stock'],
        }
    )
    if created:
        print(f"Created {product.name}")
    else:
        print(f"Already exists: {product.name}")
