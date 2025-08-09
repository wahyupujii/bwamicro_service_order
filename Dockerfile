FROM php:7.4-fpm

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    zip \
    unzip \
    libpq-dev \
    libonig-dev \
    libxml2-dev \
    libzip-dev \
    libpng-dev

# Install PHP extensions
RUN docker-php-ext-install pdo pdo_mysql mbstring exif pcntl bcmath gd

# Copy composer from official composer image
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Set working directory
WORKDIR /var/www

# Copy Laravel project to container
COPY . .

# Install PHP dependencies
# RUN composer install --no-interaction --prefer-dist --optimize-autoloader
RUN composer install

# # Set proper permissions
RUN chown -R www-data:www-data /var/www \
    && chmod -R 755 /var/www
