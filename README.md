# docker-apache-modules
Dockerized Apache 2 with ability to enable modules on runtime

## Configuration
### Environment Variables
#### A2ENMOD
Will allow you to enable multiple apache modules (coma separated).
```
A2ENMOD=proxy,proxy_ajp
```
It will trigger a a2enmod command as provided in Debian based distributions.

## Examples
### Docker Compose with Proxy AJP module 
Example `docker-compose.yml` file:
```bash
apache:
   image: davlord/apache-ajp
   volumes:
     - ./logs:/var/log/apache2/
     - ./mysite.conf:/etc/apache2/sites-enabled/mysite.conf:ro
   environment:
    - A2ENMOD=proxy,proxy_ajp
   ports:
     - "80:80"
     
tomcat:
  image: tomcat
  container_name: tomcat
  expose:
    - "8009"
```
Where `mysite.conf` could be :
```bash
<VirtualHost *:80>

ServerName www.mydomain.com
ServerAlias mydomain.com

ProxyRequests Off 
ProxyPreserveHost On

ProxyPass / ajp://tomcat:8009/
ProxyPassReverse / ajp://tomcat:8009/

LogLevel warn
ErrorLog /var/log/apache2/mydomain.com-error.log
CustomLog /var/log/apache2/mydomain.com-access.log combined
ServerSignature Off 

</VirtualHost>
```
