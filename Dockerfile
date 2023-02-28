FROM alpine:latest
COPY ./Project/ /var/www
WORKDIR /var/www/laravel
RUN apk update\
&& apk add php\ 
&& apk add apache2 && apk add openrc\ 
&& apk add php81-common php81-fpm php81-pdo php81-opcache php81-zip php81-phar php81-iconv php81-cli php81-curl php81-openssl php81-mbstring php81-tokenizer php81-fileinfo php81-json php81-xml php81-xmlwriter php81-simplexml php81-dom php81-pdo_mysql php81-pdo_sqlite php81-tokenizer php81-pecl-redis\
&& apk add --no-cache zip unzip curl sqlite\
&& apk add php81-apache2\
&& apk add composer\
&& composer install\
&& cp .env.example .env\
&& chmod 777 -R storage\
&& php artisan key:generate\
&& openrc boot apache2
COPY ./default/httpd.conf /etc/apache2/
CMD ["httpd", "-D", "FOREGROUND"]
