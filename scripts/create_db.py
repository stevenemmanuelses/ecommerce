import pymysql

host = '127.0.0.1'
user = 'root'
password = ''
port = 3306
dbname = 'variety_db'

conn = pymysql.connect(host=host, user=user, password=password, port=port)
cur = conn.cursor()
cur.execute(f"CREATE DATABASE IF NOT EXISTS `{dbname}` CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci")
conn.commit()
cur.close()
conn.close()
print('database created or already exists')
