#!/bin/bash

cp ./nginx/*.local /etc/nginx/sites-available

CUR=$PWD
cd /etc/nginx/sites-enabled
if [ ! -f "/etc/nginx/sites-available/api.local" ];
then
    sudo ln -s /etc/nginx/sites-available/api.local | true 
fi    
if [ ! -f "/etc/nginx/sites-available/apidocs.local" ]
then
    sudo ln -s /etc/nginx/sites-available/apidocs.local | true 
fi

mkdir -p /var/log/nginx/api.local/access
mkdir -p /var/log/nginx/api.local/error
mkdir -p /var/log/nginx/apidocs.local/access 
mkdir -p /var/log/nginx/apidocs.local/error

cd $CUR

nginx -t
systemctl reload nginx