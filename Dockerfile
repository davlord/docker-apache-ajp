FROM debian

MAINTAINER Vladimir Bueb "vlord@free.fr"

RUN apt-get update && apt-get -y install apache2 && apt-get clean

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2

RUN a2enmod proxy && a2enmod proxy_ajp

EXPOSE 80
EXPOSE 443

CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
