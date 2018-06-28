#!/bin/bash

cp *.local /etc/nginx/sites-available

CUR=$PWD
cd /etc/nginx/sites-enabled
sudo ln -s /etc/nginx/sites-available/elastic.local | true
sudo ln -s /etc/nginx/sites-available/kibana.local | true

mkdir -p /var/log/nginx/elastic.local/access
mkdir -p /var/log/nginx/elastic.local/error
mkdir -p /var/log/nginx/kibana.local/access 
mkdir -p /var/log/nginx/kibana.local/error

cd $CUR

nginx -t
systemctl reload nginx