FROM php:7.4-fpm-alpine

WORKDIR /var/www

RUN apk add bash mysql-client openssl nodejs npm

RUN docker-php-ext-install pdo pdo_mysql

RUN apk add --no-cache openssl

ENV DOCKERIZE_VERSION v0.6.1

RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && rm dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz

RUN curl -sS https://getcomposer.org/installer | php -- \
--install-dir=/usr/bin --filename=composer

RUN rm -rf /var/www/html

# COPY . /var/www

# RUN composer install && \
#     cp .env.example .env && \
#     php artisan key:generate && \
#     php artisan config:cache

RUN ln -s public html

EXPOSE 9000

ENTRYPOINT ["php-fpm"]
