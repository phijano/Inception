#!/bin/sh

mysql_install_db --user=root --datadir=$DATABASE_PATH

mysqld --user=root &
sleep 10

mysql_secure_installation -S $DATABASE_PATH/mysql.sock <<EOF

y
y
$DB_ROOT_PASSWORD
$DB_ROOT_PASSWORD
y
y
y
y
EOF

mysql -u root -e "CREATE DATABASE $DB_NAME"
mysql -u root -e "CREATE USER $DB_USER IDENTIFIED BY '$DB_PASSWORD'"
mysql -u root -e "GRANT ALL PRIVILEGES ON $DB_NAME.* TO $DB_USER"
mysql -u root -e "ALTER USER root@localhost IDENTIFIED BY '$DB_ROOT_PASSWORD'"

mariadb-admin --password=$DB_ROOT_PASSWORD shutdown

exec mysqld --user=root
