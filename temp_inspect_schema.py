import os
import django

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'variety.settings')
django.setup()
from django.db import connection

with connection.cursor() as cursor:
    for table in ['store_order', 'store_returnrequest', 'store_userprofile']:
        cursor.execute(f'SHOW COLUMNS FROM {table}')
        print(table, cursor.fetchall())
    cursor.execute("SELECT name FROM django_migrations WHERE app='store' ORDER BY name")
    print('migrations', cursor.fetchall())
