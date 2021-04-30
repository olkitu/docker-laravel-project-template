# Production image - build this to production
# By default we use Nginx+PHP-FPM but you can choose also Apache version
# FROM olkitu/docker-laravel-project-template:apache
FROM olkitu/docker-laravel-project-template

RUN cp /usr/local/etc/php/php.ini-production /usr/local/etc/php/php.ini \
    && sed -i -e 's/expose_php = On/expose_php = Off/' /usr/local/etc/php/php.ini

USER www-data

# Copy all files from app
COPY --chown=www-data:www-data app/. /var/www/html
RUN composer install --no-cache --no-dev -o
USER root