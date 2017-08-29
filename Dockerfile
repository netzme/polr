FROM egyptianbman/docker-centos-nginx-php

ARG APP_NAME=polr

ENV APP_HOME /opt/app/${APP_NAME}
ENV ENV_FILE ${APP_HOME}/resources/views/env.blade.php

COPY . $APP_HOME/
COPY docker /docker
RUN rm $APP_HOME/Dockerfile && rm -rf $APP_HOME/docker && cp $APP_HOME/nginx.conf /etc/nginx/  && mv $APP_HOME/polr.conf /etc/nginx/conf.d/

WORKDIR $APP_HOME

RUN chmod -R 777 $APP_HOME
RUN yum -y --enablerepo remi,remi-php56 install php-pgsql
RUN curl -sS https://getcomposer.org/installer | php
RUN php composer.phar install --no-dev -o
