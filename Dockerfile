FROM olkitu/docker-laravel-project-template

RUN cp /usr/local/etc/php/php.ini-production /usr/local/etc/php/php.ini \
    && sed -i -e 's/expose_php = On/expose_php = Off/' /usr/local/etc/php/php.ini

USER www-data

# Copy all files from app
COPY --chown=www-data:www-data app/. /var/www/html
RUN composer install --no-dev
USER root