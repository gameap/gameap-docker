FROM knik/php:7.4-cli-alpine

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
    && composer install --no-interaction --no-ansi --prefer-dist --no-dev --optimize-autoloader \
    && php artisan key:generate --force \
    && npm install \
    && npm run prod \
    && rm -rf node_modules \
    && rm -rf .npm \
    && rm -rf .composer

RUN composer require spiral/roadrunner-laravel "^5.4" \
    && php ./artisan vendor:publish --provider='Spiral\RoadRunnerLaravel\ServiceProvider' --tag=config \
    && composer require spiral/roadrunner:v2.5.3 nyholm/psr7 \
    && ./vendor/bin/rr get-binary

COPY ./entrypoint /entrypoint

CMD ["/entrypoint"]
