# Use the official nginx image with Perl support, as the base image
FROM nginx:stable-perl

# Set environment variables for the nginx user and group
ENV NGINXUSER=laravel
ENV NGINXGROUP=laravel

# Create a directory for the public files of the Laravel application
RUN mkdir -p /var/www/html/public

# Copy the nginx configuration file for the Laravel application to the container
ADD nginx/default.conf /etc/nginx/conf.d/default.conf

# Replace the default nginx user "www-data" with the custom user "laravel" in the nginx configuration
RUN sed -i "s/user www-data/user laravel/g" /etc/nginx/nginx.conf

# Create a new group for the nginx user to be added to
RUN groupadd ${NGINXGROUP}

# Create a directory for the Laravel application files and set permissions
RUN mkdir -p /var/www/laravel/public

# Create a new user "laravel" with no password, assigned to the custom group, and set their home directory and shell
RUN adduser --disabled-password --gecos '' --home /var/www/laravel --ingroup ${NGINXGROUP} --shell /bin/bash ${NGINXUSER}
