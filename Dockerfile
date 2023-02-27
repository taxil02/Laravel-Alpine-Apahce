FROM alpine:latest
COPY ./default/ /etc/nginx/http.d/
COPY ./laravel/ /var/www/
WORKDIR /var/www/laravel
RUN apk update\
&& apk add php\ 
&& apk add php81-pecl-mongodb\ 
&& echo "extension=mongodb.so" >> /etc/php81/php.ini \
&& apk add nginx && apk add openrc\ 
&& apk add php81-common php81-fpm php81-pdo php81-opcache php81-zip php81-phar php81-iconv php81-cli php81-curl php81-openssl php81-mbstring php81-tokenizer php81-fileinfo php81-json php81-xml php81-xmlwriter php81-simplexml php81-dom php81-pdo_mysql php81-pdo_sqlite php81-tokenizer php81-pecl-redis\
&& apk add php-fpm\
&& apk add --no-cache zip unzip curl sqlite nginx supervisor\
&& apk add composer\
&& composer update\
&& cp .env.example .env\
&& chmod 777 -R storage\
&& php artisan key:generate\
&& openrc boot php-fpm81\
&& openrc boot nginx
COPY entrypoint.sh /etc/
ENTRYPOINT ["sh", "/etc/entrypoint.sh"]
