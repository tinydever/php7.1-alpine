FROM php:7.1-alpine3.7

RUN apk add --no-cache  ${PHPIZE_DEPS} \
    libstdc++ \
    libpng \
    libpng-dev \
    libcurl \
    mysql \
    libjpeg \
    curl \
    libcurl \
    freetype \
    libmcrypt-dev \
    libltdl \
    libxslt-dev \
    icu-dev \
    gettext-dev \
    libmemcached-dev \
    && docker-php-ext-install mysqli shmop sockets sysvsem gd pdo pdo_mysql iconv bcmath zip xmlrpc soap intl gettext pcntl opcache \
    && docker-php-ext-configure xsl \
    && docker-php-ext-install xsl \
    && docker-php-ext-configure mcrypt \
    && docker-php-ext-install mcrypt \
    && pecl install redis \
    && pecl install mongodb \
    && pecl install memcached \
    && pecl install swoole \
    && docker-php-ext-enable redis mongodb  memcached swoole \
    && apk del ${PHPIZE_DEPS}

#opcache
ENV OPCACHE_MAX_ACCELERATED_FILES 4000
ENV OPCACHE_REVALIDATE_FREQ 60
ENV OPCACHE_MEMORY_CONSUMPTION 128
ENV OPCAHCE_INTERNED_STRINGS_BUFFER 8
ENV OPCAHCE_FAST_SHUTDOWN 1
ENV OPCACHE_SAVE_COMMENTS 0

RUN  echo "opcache.enable=1" >> /usr/local/etc/php/conf.d/docker-php-ext-opcache.ini \
  && echo "opcache.enable_cli=1" >> /usr/local/etc/php/conf.d/docker-php-ext-opcache.ini \
  && echo "opcache.revalidate_freq=${OPCACHE_REVALIDATE_FREQ}" >> /usr/local/etc/php/conf.d/docker-php-ext-opcache.ini \
  && echo "opcache.memory_consumption=${OPCACHE_MEMORY_CONSUMPTION}" >> /usr/local/etc/php/conf.d/docker-php-ext-opcache.ini \
  && echo "opcache.max_accelerated_files=${OPCACHE_MAX_ACCELERATED_FILES}" >> /usr/local/etc/php/conf.d/docker-php-ext-opcache.ini \
  && echo "opcache.interned_strings_buffer=${OPCAHCE_INTERNED_STRINGS_BUFFER}" >> /usr/local/etc/php/conf.d/docker-php-ext-opcache.ini \
  && echo "opcache.fast_shutdown=${OPCAHCE_FAST_SHUTDOWN}" >> /usr/local/etc/php/conf.d/docker-php-ext-opcache.ini \
  && echo "opcache.save_comments=${OPCACHE_SAVE_COMMENTS}" >> /usr/local/etc/php/conf.d/docker-php-ext-opcache.ini
