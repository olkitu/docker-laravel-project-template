FROM composer as composer

ENV PHP_VERSION=7.4

# Base: https://hub.docker.com/r/olkitu/docker-nginx-php-fpm
FROM olkitu/docker-nginx-php-fpm:${PHP_VERSION} as base

ENV APP_NAME=laravel \
    APP_ENV=local \
    APP_URL=http://localhost \
    DB_HOST=laravel \
    DB_DATABASE=laravel \
    DB_USERNAME=laravel \
    DB_PASSWORD=laravel

# Install required PHP packages
RUN BUILD_PACKAGES='libmcrypt-dev libxml2-dev oniguruma-dev' \ 
    && apk add --no-cache libmcrypt libxml2 $BUILD_PACKAGES \
    && docker-php-ext-install -j$(nproc) mysqli pdo pdo_mysql tokenizer xml pcntl mbstring \
    && apk del $BUILD_PACKAGES

# Copy Nginx configuration file
COPY configs/nginx-config.conf /etc/nginx/conf.d/default.conf

# Install modules via composer
COPY --from=composer /usr/bin/composer /usr/bin/composer

## Build Production

FROM base as prod

COPY composer.json composer.lock* ./
RUN composer install --no-dev

# Copy all files from app
COPY --chown=www-data:www-data app/. /var/www/html

## Build Dev

FROM base as dev
