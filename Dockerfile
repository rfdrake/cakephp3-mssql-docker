# docker build -t cakephp .
# docker run -v $PWD:/home/web -it cakephp composer create-project --prefer-dist cakephp/app testing
# edit testing/config/app.php and change the database driver..
# docker run -v $PWD:/home/web -p 8765:8765 -it cakephp testing/bin/cake server -H 0.0.0.0
# docker run -v $PWD:/home/web -p 8765:8765 -it cakephp bash -c 'cd /home/web/testing; cakephp composer require cakephp/migrations "@stable"'

FROM ubuntu:16.04

RUN apt-get update -qq && apt-get install -y curl apt-transport-https

RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - && \
    curl https://packages.microsoft.com/config/ubuntu/16.04/prod.list > /etc/apt/sources.list.d/mssql-release.list && \
    #curl https://packages.microsoft.com/config/ubuntu/16.04/mssql-server.list > /etc/apt/sources.list.d/mssql-server.list && \
    apt-get update -qq && \
    DEBIAN_FRONTEND=noninteractive ACCEPT_EULA=Y apt-get install -y php7.0 libapache2-mod-php7.0 mcrypt \
            php7.0-mcrypt php7.0-mbstring php-pear \
            php7.0-intl php7.0-zip unzip sqlite3 \
            php7.0-sqlite3 php7.0-json php7.0-xml php7.0-tidy php7.0-opcache \
            php7.0-pgsql php7.0-mysql \
            php7.0-dev apache2 msodbcsql mssql-tools unixodbc-dev-utf16 git && \
    pecl install sqlsrv-4.0.7 pdo_sqlsrv-4.0.7 && \
    echo "extension=/usr/lib/php/20151012/sqlsrv.so" >> /etc/php/7.0/apache2/php.ini && \
    echo "extension=/usr/lib/php/20151012/pdo_sqlsrv.so" >> /etc/php/7.0/apache2/php.ini && \
    echo "extension=/usr/lib/php/20151012/sqlsrv.so" >> /etc/php/7.0/cli/php.ini && \
    echo "extension=/usr/lib/php/20151012/pdo_sqlsrv.so" >> /etc/php/7.0/cli/php.ini && \
    curl -s https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && \
    locale-gen en_US.UTF-8 && groupadd -r web && useradd -g web -m -d /home/web web

WORKDIR /home/web
USER web
