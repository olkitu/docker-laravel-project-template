FROM olkitu/docker-laravel-project-template

COPY composer.json composer.lock* ./
RUN composer install --no-dev

# Copy all files from app
COPY --chown=www-data:www-data app/. /var/www/html