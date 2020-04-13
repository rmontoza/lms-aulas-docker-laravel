FROM php:7.4.4-fpm-alpine3.10
RUN apk add bash mysql-client
RUN docker-php-ext-install pdo pdo_mysql

WORKDIR /var/www
RUN rm -rf /var/www/html

COPY . /var/www

RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer
RUN chmod +x /usr/local/bin/composer

RUN composer install && \
    cp .env.example .env && \
    php artisan key:generate && \
    php artisan config:cache

RUN ln -s public html

EXPOSE 9000
ENTRYPOINT [ "php-fpm" ]
