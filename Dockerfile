FROM php:8.2-apache

# Install the packages we need
RUN apt-get update && apt-get -y install \
    autoconf \
    curl \
    g++ \
    gcc \
    git \
    libbz2-dev \
    libc-client-dev \
    libc-dev \
    libfreetype6-dev \
    libjpeg-dev \
    libmagickwand-dev \
    libmcrypt-dev \
    libpng-dev \
    libwebp-dev \
    libreadline-dev \
    libssl-dev \
    libxslt1-dev \
    libzip-dev \
    make \
    openssl \
    pkg-config \
    supervisor \
    unzip \
    wget \
    zip \
    zlib1g-dev

RUN mkdir -p /var/log/apache2 \
             /var/log/php \
             /var/log/supervisor \
             /var/www/dummy

# Install PHP packages
RUN docker-php-ext-configure gd --enable-gd --with-freetype --with-jpeg --with-webp; \
    docker-php-ext-configure intl; \
    docker-php-ext-install -j$(nproc) \
      bcmath \
      bz2 \
      calendar \
      exif \
      gd \
      gettext \
      iconv \
      intl \
      mysqli  \
      opcache \
      pcntl \
      pdo_mysql \
      soap \
      sockets \
      xsl \
      zip
RUN pecl install redis xdebug && docker-php-ext-enable redis
RUN yes '' | pecl install imagick && docker-php-ext-enable imagick
RUN docker-php-ext-enable xdebug
RUN docker-php-source delete; \
    apt-get autoremove --purge -y && apt-get autoclean -y && apt-get clean -y; \
    rm -rf /var/lib/apt/lists/*; \
    rm -rf /tmp/* /var/tmp/*

# Install the packages we need to persist. We do this here, because unused packages are removed above
RUN apt-get update && apt-get -y install \
    mariadb-client \
    nano \
    unzip


# set recommended PHP.ini settings
# see https://secure.php.net/manual/en/opcache.installation.php
RUN { \
        echo 'opcache.memory_consumption=128'; \
        echo 'opcache.interned_strings_buffer=8'; \
        echo 'opcache.max_accelerated_files=4000'; \
        echo 'opcache.revalidate_freq=2'; \
        echo 'opcache.fast_shutdown=1'; \
    } > /usr/local/etc/php/conf.d/opcache-recommended.ini
RUN { \
        echo 'error_reporting = 4339'; \
        echo 'display_errors = Off'; \
        echo 'display_startup_errors = Off'; \
        echo 'log_errors = On'; \
        echo 'error_log = /dev/stderr'; \
        echo 'log_errors_max_len = 1024'; \
        echo 'ignore_repeated_errors = On'; \
        echo 'ignore_repeated_source = Off'; \
        echo 'html_errors = Off'; \
    } > /usr/local/etc/php/conf.d/error-logging.ini
RUN { \
        echo 'xdebug.mode = debug'; \
        echo 'xdebug.remote_enable = 1'; \
        echo 'xdebug.discover_client_host = false'; \
        echo 'xdebug.client_host = host.docker.internal'; \
        echo 'xdebug.start_with_request = trigger'; \
        echo 'xdebug.idekey = PHPSTORM'; \
    } >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

RUN a2enmod rewrite headers expires


# Copy suporvisor config
COPY config/supervisor/supervisord.conf /etc/supervisord.conf


# Add an SSL certificate for *.localhost
COPY config/ssl/localhost.ext /etc/ssl/localhost.ext
RUN openssl req -x509 \
    -out /etc/ssl/localhost.crt \
    -keyout /etc/ssl/localhost.key \
    -newkey rsa:2048 -nodes -sha256 -days 1024 \
    -subj "/C=NL/ST=Zuid-Holland/O=Localhost/CN=localhost" \
    -extensions EXT \
    -config /etc/ssl/localhost.ext


#
# Install Composer
#
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer


#
# Install NodeJS
#
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash -
RUN apt-get install -y nodejs npm && node --version


#
# Installing Yarn and n globally
#
RUN npm -g install yarn n


#
# Install some node tools globally
#
RUN yarn global add @vue/cli


#
# Install Laravel installer
#
RUN composer global require laravel/installer


ENV PATH "$PATH:$HOME/.composer/vendor/bin:/root/.composer/vendor/bin:/usr/src/app/node_modules/.bin"

EXPOSE 80 443


# Let supervisord start apache
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]