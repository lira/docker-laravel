#!/bin/bash

composer install
php arisan key:generate
php artisan migrate

php-fpm