FROM library/ubuntu:14.04
MAINTAINER "linyows" <linyows@gmail.com>

ENV PHPBREW_PHP 5.6.21

RUN apt-get -y update && \
    apt-get -y install curl git php5-cli php5-intl php-pear libmcrypt-dev libicu-dev libxml2-dev \
    openssl libssl-dev libcurl4-openssl-dev bzip2 libbz2-dev build-essential autoconf libreadline-dev libxslt1-dev \
    libpcre3-dev libjpeg-dev libpng12-dev libxpm-dev libfreetype6-dev libmysqlclient-dev libt1-dev \
    libgd2-xpm-dev libgmp-dev libsasl2-dev libmhash-dev unixodbc-dev freetds-dev libpspell-dev libsnmp-dev libtidy-dev
RUN curl -sL https://github.com/phpbrew/phpbrew/raw/master/phpbrew -o /usr/local/bin/phpbrew
RUN chmod +x /usr/local/bin/phpbrew
RUN echo "source ~/.phpbrew/bashrc\nphpbrew use ${PHPBREW_PHP}" >> ~/.bashrc
RUN phpbrew init && phpbrew install ${PHPBREW_PHP} +default +mysql +mb +iconv +opcache +sqlite +intl
RUN /bin/bash -c "source ~/.phpbrew/bashrc; phpbrew switch ${PHPBREW_PHP}; phpbrew ext install xdebug; phpbrew app get composer"

RUN curl -sSL https://rvm.io/mpapis.asc | gpg --import -
RUN curl -L get.rvm.io | bash -s stable

RUN /bin/bash -l -c "rvm requirements"
RUN /bin/bash -l -c "rvm install 2.3 && rvm use 2.3"
RUN /bin/bash -l -c "gem install bundler --no-ri --no-rdoc"
RUN echo "source /etc/profile.d/rvm.sh" >> ~/.bashrc
