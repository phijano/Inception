#!/bin/sh

sleep 10

sed -i "s/my_user/$WP_USER/" /etc/php81/php-fpm.conf
sed -i "s/my_group/$WP_GROUP/" /etc/php81/php-fpm.conf

mkdir -p $SITE_PATH

wp core download --version=latest --path=$SITE_PATH

addgroup -S $WP_GROUP && adduser -S $WP_USER $WP_GROUP

chown -R $WP_USER:$WP_GROUP $SITE_PATH && chmod -R 775 $SITE_PATH

cp $SITE_PATH/wp-config-sample.php $SITE_PATH/wp-config.php
sed -i "s/database_name_here/$DB_NAME/" $SITE_PATH/wp-config.php
sed -i "s/username_here/$DB_USER/" $SITE_PATH/wp-config.php
sed -i "s/password_here/$DB_PASSWORD/" $SITE_PATH/wp-config.php
sed -i "s/localhost/mariadb/" $SITE_PATH/wp-config.php

wp core install --path=$SITE_PATH --url=$DOMAIN_NAME --title=Inception --admin_user=$WP_ADMIN --admin_password=$WP_ADMIN_PASSWORD --admin_email=$WP_ADMIN_EMAIL --allow-root

wp user create $WP_EVAL $WP_EVAL_EMAIL --user_pass=$WP_EVAL_PASSWORD --role=author --path=$SITE_PATH --allow-root

exec php-fpm81 -y /etc/php81/php-fpm.conf -F
