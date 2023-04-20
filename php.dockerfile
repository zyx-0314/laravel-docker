# Use the official PHP 8.1.18 FPM image based on Alpine 3.17 as the base image
FROM php:8.1.18-fpm-alpine3.17

# Set environment variables for the custom PHP user and group
ENV PHPUSER=laravel
ENV PHPGROUP=laravel

# Create a new group for the custom PHP user to be added to
RUN addgroup ${PHPGROUP}

# Create a new user "laravel" with no password, assigned to the custom group, and set their home directory and shell
RUN adduser --disabled-password --gecos '' --home /var/www/laravel --ingroup ${PHPGROUP} --shell /bin/bash ${PHPUSER}

# Set the user and group for the PHP-FPM process in the configuration file to the custom user and group created earlier
# RUN sed -i "s/user = www-data/user = ${PHPUSER}/g" /usr/local/etc/php-fpm.d/www.conf
# RUN sed -i "s/group = www-data/group = ${PHPGROUP}/g" /usr/local/etc/php-fpm.d/www.conf
RUN sed -i "s/user = www-data/user = ${PHPUSER}/g" /usr/local/etc/php-fpm.conf
RUN sed -i "s/group = www-data/group = ${PHPGROUP}/g" /usr/local/etc/php-fpm.conf

# Create a directory for the public files of the Laravel application
RUN mkdir -p /var/www/html/public

# Install the necessary PHP extensions for Laravel (PDO and PDO MySQL)
RUN docker-php-ext-install pdo pdo_mysql

# Set the command to run PHP-FPM with the custom configuration file and options
CMD ["php-fpm", "-y", "/usr/local/etc/php-fpm.conf", "-R"]
