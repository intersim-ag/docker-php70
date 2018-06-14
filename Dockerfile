FROM php:7.0-fpm-jessie

ENV COMPOSER_ALLOW_SUPERUSER=1 \
    ACCEPT_EULA=Y

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        apt-transport-https \
        curl \
        git \
        libcurl4-openssl-dev \
        libfreetype6-dev \
        libicu-dev \
        libjpeg62-turbo-dev \
        libldap2-dev \
        libpng-dev \
        libtidy-dev \
        locales \
        ssh-client \

    # PHP extensions
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu \
    && docker-php-ext-install -j$(nproc) \
        calendar \
        curl \
        gd \
        gettext \
        intl \
        ldap \
        opcache \
        tidy \
        zip \

    # Sql Server drivers
    && curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
    && curl https://packages.microsoft.com/config/debian/8/prod.list > /etc/apt/sources.list.d/mssql-release.list \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
        msodbcsql17 \
        unixodbc-dev \
    && pecl install pdo_sqlsrv \

    # Composer
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \

    # node.js
    && curl -sL https://deb.nodesource.com/setup_8.x | bash \
    && apt-get install -y --no-install-recommends nodejs \
    && npm install -g gulp-cli \

    # Clean temporary files
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

CMD []
