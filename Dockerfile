# ---------- Composer (dùng để cài dependencies PHP ở stage runtime) ----------
FROM composer:2 AS composer

# ---------- Giai đoạn 1: Build frontend (Vite) ----------
FROM node:20-alpine AS frontend
WORKDIR /app
COPY BaseCode/package.json BaseCode/package-lock.json ./
RUN npm ci --no-audit --no-fund
COPY BaseCode/ .
RUN npm run build

# ---------- Giai đoạn 2: Runtime PHP + Apache ----------
FROM php:8.2-apache

# Extensions cần cho Laravel + xử lý ảnh (GD/EXIF)
RUN apt-get update && apt-get install -y --no-install-recommends \
        libpng-dev libjpeg62-turbo-dev libfreetype6-dev libzip-dev \
        libicu-dev libonig-dev unzip git \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j"$(nproc)" \
        pdo_mysql bcmath exif gd intl zip \
    && rm -rf /var/lib/apt/lists/*

# Cài Composer (lấy từ stage 'composer' phía trên)
COPY --from=composer /usr/bin/composer /usr/local/bin/composer

# Bật mod Apache + trỏ DocumentRoot vào /public (Laravel)
RUN a2enmod rewrite headers
ENV APACHE_DOCUMENT_ROOT=/var/www/html/public
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' \
            -e 's!<Directory /var/www/>!<Directory ${APACHE_DOCUMENT_ROOT}>!g' \
    /etc/apache2/sites-available/*.conf /etc/apache2/envvars

WORKDIR /var/www/html

# Composer: cài dependencies PHP (bỏ package dev, chạy sau khi có đủ mã nguồn)
COPY BaseCode/composer.json BaseCode/composer.lock ./
RUN COMPOSER_ALLOW_SUPERUSER=1 composer install --no-dev --no-scripts \
    --no-interaction --prefer-dist --ignore-platform-reqs

# Copy toàn bộ mã nguồn (nằm trong thư mục BaseCode/) + kết quả build Vite
COPY BaseCode/ .
COPY --from=frontend /app/public/build ./public/build

# Tạo .env từ example (đổi DB_HOST sang tên service trong compose)
RUN cp .env.example .env \
    && sed -i 's/^DB_HOST=.*/DB_HOST=mysql/' .env \
    && php artisan package:discover --ansi \
    && php artisan storage:link \
    && chown -R www-data:www-data storage bootstrap/cache public

EXPOSE 80
CMD ["apache2-foreground"]
