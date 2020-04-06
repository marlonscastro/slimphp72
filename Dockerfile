FROM php:7.2-apache
LABEL MAINTEINER="MarlonSC"

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
# Tools
    apt-utils \
    wget \
    git \
    nano \
    iputils-ping \
    default-mysql-client \
    locales \
    # imagemagick \
    # graphicsmagick \
    # ghostscript \
# Configure PHP
    libxml2-dev libfreetype6-dev \
    libjpeg62-turbo-dev \
    libmcrypt-dev \
    libpng-dev && \
    docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ && \
    docker-php-ext-install -j$(nproc) mysqli soap gd zip opcache pdo pdo_mysql && \
    echo 'always_populate_raw_post_data = -1\nmax_execution_time = 240\nmemory_limit = 512M\nmax_input_vars = 1500\nupload_max_filesize = 200M\npost_max_size = 300M' > /usr/local/etc/php/conf.d/typo3.ini && \
# Configure bash
    echo 'export LS_OPTIONS="--color=auto"\nalias ls="ls $LS_OPTIONS"\nalias ll="ls $LS_OPTIONS -aGFlh"\nalias l="ls $LS_OPTIONS -FG"' > ~/.bashrc && \
# Configure Apache & clean
    a2enmod rewrite && \
    apt-get clean && \
    apt-get -y purge \
        libxml2-dev libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng12-dev && \
    rm -rf /var/lib/apt/lists/* /usr/src/*
# ======= composer =======
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
# Set locales
# RUN locale-gen en_US.UTF-8 en_GB.UTF-8 de_DE.UTF-8 es_ES.UTF-8 fr_FR.UTF-8 it_IT.UTF-8 km_KH sv_SE.UTF-8 fi_FI.UTF-8
RUN locale-gen en_US.UTF-8 pt_BR.UTF-8

COPY . /var/www/html/
COPY 000-default.conf /etc/apache2/sites-enabled/000-default.conf
COPY ports.conf /etc/apache2/ports.conf

RUN composer install 

EXPOSE 8080
# CMD ["php", "-S", "localhost:8080", "-t", "/var/www/html/", "index.php"]

#ADD typo3.default.conf /etc/apache2/sites-enabled/000-default.conf
