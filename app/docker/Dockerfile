FROM wordpress:6.4-php8.2-apache

# Устанавливаем Redis extension
RUN pecl install redis \
    && docker-php-ext-enable redis

# Копируем wp-config
COPY app/wp-config.php /var/www/html/wp-config.php

RUN chown -R www-data:www-data /var/www/html
