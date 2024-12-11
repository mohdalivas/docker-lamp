FROM php:8.3-apache

ENV TZ=${TZ:-UTC}

ADD crontab /etc/cron.d/moodle-cron

COPY cmd.sh /cmd.sh
COPY ./php.ini ${PHP_INI_DIR}/conf.d/99-php.ini
COPY ssl/server.key /etc/ssl/private/server.key
COPY ssl/server.pem /etc/ssl/certs/server.pem

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone && \
        apt-get update && apt-get install -y \
        zip \
        libzip-dev \
        libicu-dev \
        libxml2-dev \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
        libwebp-dev \
        cron && \
        docker-php-ext-configure gd --with-freetype --with-jpeg --with-webp && \
        docker-php-ext-configure intl && \
        docker-php-ext-install -j$(nproc) mysqli pdo pdo_mysql opcache zip gd soap intl exif && \
        chmod +x /cmd.sh && \
        echo "ServerName localhost:80" >> /etc/apache2/apache2.conf && \
        sed -i 's/ssl-cert-snakeoil/server/' /etc/apache2/sites-available/default-ssl.conf && \
        a2enmod rewrite && \
        a2enmod headers && \
        a2enmod ssl && \
        a2ensite default-ssl && \
        chmod 0644 /etc/cron.d/moodle-cron && touch /var/log/cron.log

CMD ["/cmd.sh"]
