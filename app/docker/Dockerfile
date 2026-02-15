FROM wordpress:6.4-apache

RUN pecl install redis && docker-php-ext-enable redis

RUN chown -R www-data:www-data /var/www/html
