FROM php:8.2-fpm

# Устанавливаем системные зависимости
RUN apt-get update && apt-get install -y \
    libzip-dev \
    zip \
    unzip \
    curl \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    ca-certificates \
    && update-ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Устанавливаем PHP расширения
RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install \
    pdo \
    pdo_mysql \
    mysqli \
    gd \
    zip \
    opcache

# Устанавливаем Redis extension
RUN pecl install redis \
    && docker-php-ext-enable redis

# Скачиваем WordPress в /tmp
RUN curl -fsSL https://wordpress.org/latest.tar.gz -o /tmp/wordpress.tar.gz \
    && tar -xzf /tmp/wordpress.tar.gz -C /tmp \
    && mkdir -p /var/www/html \
    && cp -R /tmp/wordpress/* /var/www/html/ \
    && rm -rf /tmp/wordpress /tmp/wordpress.tar.gz

# Права
COPY app/wp-config.php /var/www/html/wp-config.php

RUN chown -R www-data:www-data /var/www/html

WORKDIR /var/www/html

EXPOSE 9000

CMD ["php-fpm"]
