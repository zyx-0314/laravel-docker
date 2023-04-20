FROM composer:lts

ENV COMPOSERUSER=laravel
ENV COMPOSERGROUP=laravel

RUN addgroup ${COMPOSERGROUP}

RUN adduser --disabled-password --gecos '' --home /var/www/laravel --ingroup ${COMPOSERGROUP} --shell /bin/bash ${COMPOSERUSER}