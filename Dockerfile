FROM php:7.1-alpine

# add run deps
RUN set -e \
	&& apk add --no-cache --virtual .rundeps \
		git \
		bash \
		docker \
		openssh-client \
		tar \
		gzip \
		ca-certificates \
		openssl \
		icu-libs \
		zlib \
		freetype \
		libjpeg-turbo \
		libpng \
		libmcrypt \
		postgresql-libs
#
# add build deps that will be removed
RUN set -e \
	&& apk add --no-cache --virtual .builddeps \
		$PHPIZE_DEPS \
		pkgconf \
		icu-dev \
		libjpeg-turbo-dev \
		libpng-dev \
		freetype-dev \
		zlib-dev \
		libmcrypt-dev \
		postgresql-dev \
#
# add php extensions
	&& pecl install \
		apcu \
		redis \
		mongodb \
	&& docker-php-ext-enable \
		apcu \
		redis \
		mongodb \
	&& docker-php-ext-configure \
		gd \
			--with-freetype-dir=/usr/include/ \
			--with-jpeg-dir=/usr/include/ \
			--with-png-dir=/usr/include/ \
	&& docker-php-ext-install \
		intl \
		mbstring \
		pdo \
		pdo_mysql \
		pdo_pgsql \
		pgsql \
		opcache \
		sockets \
		bcmath \
		gd \
		zip \
		mcrypt \
# Cleanup to keep the images size small
	&& apk del --no-cache .builddeps

# add php composer
RUN set -e \
	&& curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer

# add kubectl
ARG KUBECTL_VERSION=1.9.3
RUN set -e \
	&& wget -cq -O \
		/usr/bin/kubectl \
		https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl \
	&& chmod +x /usr/bin/kubectl
