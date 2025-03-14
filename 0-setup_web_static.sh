#!/usr/bin/env bash
# Sets up a web server for deployment of web_static.

apt-get update
apt-get install -y nginx

mkdir -p /data/web_static/releases/test/
mkdir -p /data/web_static/shared/
echo "Holberton School" > /data/web_static/releases/test/index.html
ln -sf /data/web_static/releases/test/ /data/web_static/current

chown -R ubuntu /data/
chgrp -R ubuntu /data/

printf %s "server {
#   listen 80 default_server;
#    listen [::]:80 default_server;
#    add_header X-Served-By $HOSTNAME;
#    root   /var/www/html;
#    index  index.html index.htm;

    listen 80;
    server_name codeslap www.codeslap.tech;

    location / {
        include proxy_params;
        proxy_pass http://unix:/home/ubuntu/flask/flask.sock;
    }

#    location /hbnb_static {
#        alias /data/web_static/current;
#        index index.html index.htm;
#    }

    location /redirect_me {
        return 301 https://www.youtube.com/watch?v=QH2-TGUlw\u4?;
    }

    error_page 404 /404.html;
    location /404 {
      root /var/www/html;
      internal;
    }
}" > /etc/nginx/sites-available/default

service nginx restart
