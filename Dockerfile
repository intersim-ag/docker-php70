FROM php:7.0

# Install various dependencies
RUN apt-get update -yqq
RUN apt-get install -yqq git zlib1g-dev libpcre3-dev

# Install PHP extensions
RUN docker-php-ext-install zip opcache

# Install composer
RUN curl -sS https://getcomposer.org/installer | php
RUN php composer.phar install

# Install node.js
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash 
RUN apt-get install -y nodejs

# Install gulp
RUN npm install -g gulp-cli
