FROM caddy/caddy:latest

# The base image expects /config and /data volumes.
# /data is important, as it contains the TLS certs Caddy manages.
# /config maintains nativized configuration. It can be colocated w/ /data.
# In both cases, the image will store its data in a caddy subdirectory.

WORKDIR /

# -----------------------------------------------------------------
# This section installs and configures PHP7

ARG PUID="1000"
ARG PGID="1000"

RUN apk add --no-cache \
  php7-fpm \
  curl \
  git \
  tzdata
#  tar \
#  mailcap \
#  openssh-client \

# Essential PHP Extensions
RUN apk add --no-cache \
  php7-bcmath \
  php7-ctype \
  php7-curl \
  php7-dom \
  php7-exif \
  php7-fileinfo \
  php7-gd \
  php7-iconv \
  php7-json \
  php7-mbstring \
  php7-opcache \
  php7-pdo_sqlite \
  php7-phar \
  php7-session \
  php7-simplexml \
  php7-sqlite3 \
  php7-tokenizer \
  php7-pdo
#  php7-xml \
#  php7-xmlreader \
#  php7-xmlwriter \
#  php7-zip \
#  php7-openssl \
#  php7-pdo_mysql \
#  php7-pdo_pgsql \
#  php7-mysqli \
#  php7-pgsql \

# Symlink php to php7
RUN ln -sf /usr/sbin/php7 /usr/bin/php && \
    ln -sf /usr/sbin/php-fpm7 /usr/bin/php-fpm

# Add a PHP www-user instead of nobody; allow environment vars into PHP
RUN addgroup -g ${PGID} www-user && \
  adduser -D -H -u ${PUID} -G www-user www-user && \
  sed -i "s|^user = .*|user = www-user|g" /etc/php7/php-fpm.d/www.conf && \
  sed -i "s|^group = .*|group = www-user|g" /etc/php7/php-fpm.d/www.conf && \
  echo "clear_env = no" >> /etc/php7/php-fpm.conf

# Composer not needed for a fully-precanned PHP service
#RUN curl --silent --show-error --fail --location \
#  --header "Accept: application/tar+gzip, application/x-gzip, application/octet-stream" \
#  "https://getcomposer.org/installer" \
#  | php -- --install-dir=/usr/bin --filename=composer

# -----------------------------------------------------------------

# We need a Caddyfile which:
# 1. Enables PHP7 with all appropriate modules.
# 2. Sets the URI and WikkaWiki content location as specified in $WikiURI
# 3. Exposes port 80 on localhost (service only)
COPY Caddyfile /etc/caddy/Caddyfile

# Pull the latest WikkaWiki code
RUN git clone https://github.com/bakoontz/WikkaWiki.git /srv

# Configuration specific to this runtime 
COPY wikka.config.php /srv

# Logs and errors will be flowing on stdout

EXPOSE 80

# The following important data must be persistent outside the container FS:
# /mnt/wikka.sqlite contains the wiki data
# /mnt/certs/ for caddy maintaining TLS identity
# /mnt/env.sh configuring parameters
# /mnt/static/ Additional web pages 

# Starting caddy is all that's needed, so no need to provide CMD, ENTRYPOINT, etc
