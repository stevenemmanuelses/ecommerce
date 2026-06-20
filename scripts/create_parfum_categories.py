import os
import sys
import django

BASE_DIR = os.path.abspath(os.path.join(os.path.dirname(__file__), '..'))
if BASE_DIR not in sys.path:
    sys.path.insert(0, BASE_DIR)

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'variety.settings')
django.setup()

from store.models import Category, Product

categories = [
    ('Extrait de Parfum', 'extrait-de-parfum'),
    ('Eau de Parfum (EDP)', 'eau-de-parfum-edp'),
    ('Eau de Toilette (EDT)', 'eau-de-toilette-edt'),
    ('Eau de Cologne (EDC)', 'eau-de-cologne-edc'),
    ('Eau Fraiche', 'eau-fraiche'),
]

created = []
for name, slug in categories:
    obj, was_created = Category.objects.get_or_create(slug=slug, defaults={'name': name})
    if was_created:
        created.append(obj)
        print(f"Created category: {name}")
    else:
        print(f"Category already exists: {name}")

# Simple assignment rules for existing products (best-effort)
for p in Product.objects.all():
    lower = (p.name or '').lower()
    assigned = None
    if 'extrait' in lower:
        assigned = 'extrait-de-parfum'
    elif 'eau de parfum' in lower or 'edp' in lower:
        assigned = 'eau-de-parfum-edp'
    elif 'eau de toilette' in lower or 'edt' in lower:
        assigned = 'eau-de-toilette-edt'
    elif 'eau de cologne' in lower or 'cologne' in lower or 'edc' in lower:
        assigned = 'eau-de-cologne-edc'
    elif 'eau fraiche' in lower or 'fraiche' in lower:
        assigned = 'eau-fraiche'

    if assigned:
        cat = Category.objects.filter(slug=assigned).first()
        if cat and p.category != cat:
            p.category = cat
            p.save()
            print(f"Assigned product '{p.name}' to category '{cat.name}'")

print('Done.')
