Variety - E-Commerce (Django + XAMPP MySQL)

Quick setup

1. Install Python 3.11+ and pip.
2. Install XAMPP and start MySQL (MariaDB) and Apache if needed.
3. Create a database `variety_db` in phpMyAdmin.
4. In project root, create a virtualenv and install requirements:

```powershell
python -m venv .venv
.\.venv\Scripts\Activate.ps1
pip install -r requirements.txt
```

5. Configure DB credentials in `variety/settings.py` or set env vars: `DB_NAME`, `DB_USER`, `DB_PASSWORD`, `DB_HOST`, `DB_PORT`.
6. Run migrations and create superuser:

```powershell
python manage.py migrate
python manage.py createsuperuser
python manage.py runserver
```

Notes
- This scaffold uses `PyMySQL` to connect to XAMPP's MySQL/MariaDB. If you prefer `mysqlclient`, update `requirements.txt` and settings accordingly.
- Templates are under `templates/` and the main app is `store`.
