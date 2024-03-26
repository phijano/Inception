FROM alpine:3.18.6

RUN apk -i update && apk -i upgrade \
  && apk -i add \
  php81 \
  php81-fpm \
  php81-mysqli \
  php81-phar \
  php81-mbstring \
  && rm -rf /var/cache/apk/*

ADD https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar /usr/bin/wp

RUN chmod +x /usr/bin/wp

COPY conf/php-fpm.conf /etc/php81/php-fpm.conf

COPY ./tools/wordpress_install.sh /

RUN chmod +x wordpress_install.sh

CMD ["/wordpress_install.sh"]
