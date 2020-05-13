FROM knik/php:7.4-swoole-alpine

LABEL author="Nikita Kuznetsov" maintainer="nikita.hldm@gmail.com"

RUN apk update && apk add --update-cache \
        git \
        npm \
    && rm -rf /var/cache/apk/* \
    && adduser --home /var/www/gameap --disabled-password gameap

USER gameap

WORKDIR /var/www/gameap

RUN git clone https://github.com/et-nik/gameap /var/www/gameap \
    && cp .env.example .env \
    && composer install --no-dev --optimize-autoloader \
    && php artisan key:generate --force \
    && npm install \
    && npm run prod \
    && rm -rf node_modules \
    && rm -rf .npm \
    && rm -rf .composer

RUN composer require --update-no-dev --optimize-autoloader "swooletw/laravel-swoole" \
    && php artisan vendor:publish --tag=laravel-swoole \
    && sed -i '/^.*providers.*/a Silber\\Bouncer\\BouncerServiceProvider::class,' config/swoole_http.php \
    && sed -i '/^.*providers.*/a Gameap\\Providers\\AppServiceProvider::class,' config/swoole_http.php \
    && sed -i '/^.*providers.*/a Gameap\\Providers\\AuthServiceProvider::class,' config/swoole_http.php \
    && sed -i '/^.*providers.*/a Illuminate\\Auth\\AuthServiceProvider::class,' config/swoole_http.php

COPY ./entrypoint /entrypoint

CMD ["/entrypoint"]