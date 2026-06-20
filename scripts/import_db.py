import pymysql
from pymysql.constants import CLIENT
import os
from pathlib import Path

# Paths
BASE_DIR = Path(__file__).resolve().parent.parent
SQL_FILE = BASE_DIR / 'variety_db.sql'
ENV_FILE = BASE_DIR / '.env'

def load_dotenv(dotenv_path):
    if not dotenv_path.exists():
        return
    for raw_line in dotenv_path.read_text(encoding='utf-8').splitlines():
        line = raw_line.strip()
        if not line or line.startswith('#') or '=' not in line:
            continue
        key, value = line.split('=', 1)
        os.environ[key.strip()] = value.strip().strip('"').strip("'")

# Load environment variables from .env
load_dotenv(ENV_FILE)

# DB settings from environment
host = os.getenv('DB_HOST')
port = int(os.getenv('DB_PORT', 3306))
user = os.getenv('DB_USER')
password = os.getenv('DB_PASSWORD')
database = os.getenv('DB_NAME')

if not host or not user or not password or not database:
    print("Error: Missing database credentials in .env file!")
    exit(1)

print(f"Reading SQL file from {SQL_FILE}...")
if not SQL_FILE.exists():
    print("Error: SQL file not found!")
    exit(1)

sql_content = "SET SESSION sql_require_primary_key = OFF;\n" + SQL_FILE.read_text(encoding='utf-8')

print("Connecting to Aiven MySQL via SSL...")
try:
    conn = pymysql.connect(
        host=host,
        port=port,
        user=user,
        password=password,
        database=database,
        ssl={'ssl_mode': 'REQUIRED'},
        client_flag=CLIENT.MULTI_STATEMENTS
    )
    print("Connection established successfully!")
    
    with conn.cursor() as cursor:
        print("Executing SQL dump...")
        cursor.execute(sql_content)
        conn.commit()
        print("SQL execution complete. Consuming result sets...")
        
        # Consume any additional result sets returned by multi-statement execution
        count = 1
        while cursor.nextset():
            count += 1
            
        print(f"Successfully processed {count} statement result sets.")
        
    conn.close()
    print("Import complete! Database variety_db.sql has been migrated successfully.")
except Exception as e:
    print(f"Error during import: {e}")
    exit(1)
