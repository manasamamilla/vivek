FROM php:8.0-apache

RUN apt-get update && apt-get install -y \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libmcrypt-dev \
    libpng-dev \
    libzip-dev \
    zip \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd mysqli pdo_mysql opcache zip

RUN a2enmod rewrite

RUN curl -fsSL -o latest.tar.bz2 https://download.nextcloud.com/server/releases/latest.tar.bz2 \
    && tar -xjf latest.tar.bz2 --strip-components=1 \
    && rm latest.tar.bz2 \
    && chown -R www-data:www-data /var/www/html

EXPOSE 80

CMD ["apache2-foreground"]