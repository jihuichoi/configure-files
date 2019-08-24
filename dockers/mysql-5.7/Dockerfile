FROM mysql/mysql-server
# COPY root-config.sql /docker-entrypoint-initdb.d/root-config.sql
# COPY backup.sql /docker-entrypoint-initdb.d/backup.sql
COPY mysql.conf /etc/mysql/mysql.conf.d/mysqld.cnf
ENV MYSQL_ROOT_PASSWORD ''
ENV MYSQL_ALLOW_EMPTY_PASSWORD 1
ENV MYSQL_DATABASE watssu
RUN default_authentication_plugin=mysql_native_password
