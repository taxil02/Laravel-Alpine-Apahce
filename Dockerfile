FROM alpine:latest
RUN apk update\
&& apk add php\ 
&& apk add php81-pecl-mongodb\ 
&& echo "extension=mongodb.so" >> /etc/php81/php.ini \
&& apk add apache2 && apk add openrc\ 
&& apk add php81-common php81-fpm php81-pdo php81-opcache php81-zip php81-phar php81-iconv php81-cli php81-curl php81-openssl php81-mbstring php81-tokenizer php81-fileinfo php81-json php81-xml php81-xmlwriter php81-simplexml php81-dom php81-pdo_mysql php81-pdo_sqlite php81-tokenizer php81-pecl-redis\
&& apk add php-fpm
COPY ./default/ /etc/apache/http.d/
COPY ./laravel/ /var/www/
WORKDIR /var/www/laravel
RUN apk add composer\
&& composer update\
&& cp .env.example .env
RUN php artisan key:generate\
&& openrc boot php-fpm81\
&& openrc boot apache2\
&& chmod 777 -R /var/www/laravel 
COPY entrypoint.sh /etc/
ENTRYPOINT ["sh", "/etc/entrypoint.sh"]

