FROM ruby:2

ENV PRONTO_ROOT /data
WORKDIR $PRONTO_ROOT

RUN apt-get update -y && apt-get install -y \
    cmake \
    php5

RUN gem install pronto -v "< 0.9.3" && \
    gem install pronto-phpcs && \
    gem install pronto-phpmd

ENV COMPOSER_HOME /composer
ENV PATH /composer/vendor/bin:$PATH
ENV COMPOSER_ALLOW_SUPERUSER 1

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN composer global require \
    squizlabs/php_codesniffer \
    phpmd/phpmd

CMD [ "pronto", "run" ]
