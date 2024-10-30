# Usa una imagen base de PHP con Composer y extensiones necesarias
FROM php:8.2-fpm

# Instala Composer y dependencias adicionales
RUN apt-get update && apt-get install -y \
    libpng-dev \
    zip \
    unzip \
    && docker-php-ext-install pdo_mysql

# Instala Composer en la versión 2.8
COPY --from=composer:2.8 /usr/bin/composer /usr/bin/composer

# Establece el directorio de trabajo
WORKDIR /var/www/html

# Copia el código fuente de Laravel
COPY . .

# Instala dependencias de Laravel
RUN composer install

# Configura permisos
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache

# Expone el puerto 8000
EXPOSE 8000

# Comando para iniciar Laravel
CMD php artisan serve --host=0.0.0.0 --port=8000
