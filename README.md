# docker-apache-ajp
Dockerized apache with mod_proxy_ajp enabled.

## Docker Compose Example
Example `docker-compose.yml` file:
```bash
apache:
   image: davlord/apache-ajp
   volumes:
     - ./logs:/var/log/apache2/
     - ./mysite.conf:/etc/apache2/sites-enabled/mysite.conf:ro
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
