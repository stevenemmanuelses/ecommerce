import os
import django

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'variety.settings')
django.setup()
from django.db import connection

with connection.cursor() as cursor:
    cursor.execute("SHOW COLUMNS FROM store_order LIKE 'total_price'")
    if cursor.fetchone() is None:
        print('Adding total_price to store_order')
        cursor.execute("ALTER TABLE store_order ADD COLUMN total_price DECIMAL(10,2) NOT NULL DEFAULT 0")
    else:
        print('total_price already exists')
