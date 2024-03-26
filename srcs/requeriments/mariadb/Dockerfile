FROM alpine:3.18.6

RUN apk -i update && apk -i upgrade \
  && apk -i add \
  mysql \
  mysql-client \
  && rm -rf /var/cache/apk/*

COPY ./conf/mariadb.cnf /etc/my.cnf.d/

COPY ./tools/mariadb.sh /

RUN chmod +x mariadb.sh

CMD ["/mariadb.sh"]
