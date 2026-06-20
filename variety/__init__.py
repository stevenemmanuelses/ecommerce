import pymysql
# Some Django versions check for mysqlclient version; make PyMySQL report
# a compatible version so Django accepts it when using PyMySQL.
pymysql.version_info = (1, 4, 6, "final", 0)
pymysql.install_as_MySQLdb()
