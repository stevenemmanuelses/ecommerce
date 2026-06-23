import os
from pathlib import Path

BASE_DIR = Path(__file__).resolve().parent.parent


def _load_dotenv(dotenv_path: Path) -> None:
    if not dotenv_path.exists():
        return

    for raw_line in dotenv_path.read_text(encoding='utf-8').splitlines():
        line = raw_line.strip()
        if not line or line.startswith('#') or '=' not in line:
            continue

        key, value = line.split('=', 1)
        key = key.strip()
        value = value.strip().strip('"').strip("'")
        os.environ[key] = value


_load_dotenv(BASE_DIR / '.env')

def _get_bool_env(name: str, default: str = 'False') -> bool:
    value = os.getenv(name, default)
    return value.strip().lower() in ('1', 'true', 'yes', 'on')


def _normalize_midtrans_key(value: str | None, is_production: bool) -> str | None:
    if value is None:
        return None

    cleaned_value = value.strip().strip('"').strip("'")
    if not cleaned_value:
        return None

    return cleaned_value


MIDTRANS_IS_PRODUCTION = _get_bool_env('MIDTRANS_IS_PRODUCTION', 'False')
MIDTRANS_SERVER_KEY = _normalize_midtrans_key(os.getenv('MIDTRANS_SERVER_KEY'), MIDTRANS_IS_PRODUCTION)
MIDTRANS_CLIENT_KEY = _normalize_midtrans_key(os.getenv('MIDTRANS_CLIENT_KEY'), MIDTRANS_IS_PRODUCTION)
MIDTRANS_MERCHANT_ID = os.getenv('MIDTRANS_MERCHANT_ID', '').strip() or None

# Print startup diagnostics for Midtrans
print("\n--- MIDTRANS STARTUP DIAGNOSTICS ---")
print(f"  MIDTRANS_IS_PRODUCTION : {MIDTRANS_IS_PRODUCTION} (Active Env: {'Production' if MIDTRANS_IS_PRODUCTION else 'Sandbox'})")
print(f"  MIDTRANS_MERCHANT_ID   : {MIDTRANS_MERCHANT_ID} (Length: {len(MIDTRANS_MERCHANT_ID) if MIDTRANS_MERCHANT_ID else 0})")
print(f"  MIDTRANS_SERVER_KEY    : {'Loaded' if MIDTRANS_SERVER_KEY else 'Not Loaded'} (Length: {len(MIDTRANS_SERVER_KEY) if MIDTRANS_SERVER_KEY else 0}, Prefix: {MIDTRANS_SERVER_KEY[:14] if MIDTRANS_SERVER_KEY else 'N/A'})")
print(f"  MIDTRANS_CLIENT_KEY    : {'Loaded' if MIDTRANS_CLIENT_KEY else 'Not Loaded'} (Length: {len(MIDTRANS_CLIENT_KEY) if MIDTRANS_CLIENT_KEY else 0}, Prefix: {MIDTRANS_CLIENT_KEY[:14] if MIDTRANS_CLIENT_KEY else 'N/A'})")
print("------------------------------------\n")

MIDTRANS_IS_SANITIZED = _get_bool_env('MIDTRANS_IS_SANITIZED', 'False')
MIDTRANS_IS_3DS = _get_bool_env('MIDTRANS_IS_3DS', 'False')

SECRET_KEY = os.getenv('SECRET_KEY', 'replace-this-with-a-secure-key')
DEBUG = os.getenv('DEBUG', 'True').lower() in ('1', 'true', 'yes', 'on')
ALLOWED_HOSTS = [host.strip() for host in os.getenv('ALLOWED_HOSTS', '').split(',') if host.strip()]
LOGIN_URL = '/login/'

INSTALLED_APPS = [
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    'django.contrib.humanize',
    'store',
]

MIDDLEWARE = [
    'django.middleware.security.SecurityMiddleware',
    'whitenoise.middleware.WhiteNoiseMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.middleware.common.CommonMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
]

ROOT_URLCONF = 'variety.urls'

TEMPLATES = [
    {
        'BACKEND': 'django.template.backends.django.DjangoTemplates',
        'DIRS': [BASE_DIR / 'templates'],
        'APP_DIRS': True,
        'OPTIONS': {
            'context_processors': [
                'django.template.context_processors.debug',
                'django.template.context_processors.request',
                'django.contrib.auth.context_processors.auth',
                'django.contrib.messages.context_processors.messages',
                'store.context_processors.cart_count',
                'store.context_processors.categories',
            ],
        },
    },
]

WSGI_APPLICATION = 'variety.wsgi.application'

DATABASE_ENGINE = os.getenv('DB_ENGINE', 'django.db.backends.mysql')
DATABASES = {
    'default': {
        'ENGINE': DATABASE_ENGINE,
        'NAME': os.getenv('DB_NAME', 'variety_db'),
        'USER': os.getenv('DB_USER', 'root'),
        'PASSWORD': os.getenv('DB_PASSWORD', ''),
        'HOST': os.getenv('DB_HOST', '127.0.0.1'),
        'PORT': os.getenv('DB_PORT', '3306'),
    }
}

# Add SSL connection options for secure database hosting like Aiven MySQL
db_ssl_mode = os.getenv('DB_SSL_MODE')
db_host = os.getenv('DB_HOST', '')
if db_ssl_mode or 'aivencloud.com' in db_host:
    ssl_mode = db_ssl_mode or 'REQUIRED'
    DATABASES['default']['OPTIONS'] = {
        'ssl': {
            'ssl_mode': ssl_mode
        }
    }

AUTH_PASSWORD_VALIDATORS = []

SESSION_COOKIE_AGE = 900
SESSION_SAVE_EVERY_REQUEST = True
SESSION_EXPIRE_AT_BROWSER_CLOSE = False

LANGUAGE_CODE = 'en-us'
TIME_ZONE = 'UTC'
USE_I18N = True
USE_TZ = True

STATIC_URL = '/static/'
STATICFILES_DIRS = [BASE_DIR / 'static']
STATIC_ROOT = BASE_DIR / 'staticfiles'

STORAGES = {
    "default": {
        "BACKEND": "django.core.files.storage.FileSystemStorage",
    },
    "staticfiles": {
        "BACKEND": "whitenoise.storage.CompressedManifestStaticFilesStorage",
    },
}

MEDIA_URL = '/media/'
MEDIA_ROOT = BASE_DIR / 'media'

DEFAULT_AUTO_FIELD = 'django.db.models.BigAutoField'
