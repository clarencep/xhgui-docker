FROM clarencep/lap7:centos7

VOLUME ['/var/www/xhgui', '/data/mongodb']

COPY . /root/docker

RUN mkdir -p /etc/httpd/vhosts \
    && cp -f /root/docker/httpd/0_default.conf  /etc/httpd/vhosts/ \
    && yum install -y zip php71w-pear php71w-devel gcc make wget \
    && yum install -y openssl-devel \
    && yum install -y mongodb-server supervisor \
    && pecl install mongodb \
    && echo 'extension=mongodb.so' > /etc/php.d/mongodb.ini \
    # install PHP extension tideways: \
    && mkdir -p /usr/src/php-profiler-extension \
    && wget -O /usr/src/php-profiler-extension.tar.gz https://github.com/tideways/php-profiler-extension/archive/v4.1.2.tar.gz \
    && tar -xzf /usr/src/php-profiler-extension.tar.gz -C /usr/src/php-profiler-extension --strip-components=1 \
    && cd /usr/src/php-profiler-extension && phpize  \
    && ./configure && make && make install \
    && echo 'extension=tideways.so' > /etc/php.d/tideways.ini \
    && echo 'tideways.auto_prepend_library=0' >> /etc/php.d/tideways.ini \
    # cleanup: \
    && yum erase -y zip php71w-pear php71w-devel openssl-devel gcc make wget \
    && find /var/log -type f -print0 | xargs -0 rm -rf /root/docker /tmp/* \
    && mkdir -p /var/log/httpd \
    && yum clean all

EXPOSE 80 27017

CMD /usr/bin/supervisord -n
