#!/bin/bash
# This script will auto-renew the SSL certificate for the domain using certbot and nginx
# version 1.1

DOMAIN="devops-lab.click"
    # Change directory to nginx
    echo "Change dir" cd ~/nginx
    # Check current directory 
    echo "Current dir: pwd"
    # Stop Nginx container 
    docker container stop nginx
    # Check domain var
    echo "Domain to renew: $DOMAIN"
    # Renew the certificate
    sudo certbot certonly --force-renewal --non-interactive --agree-tos --standalone -d $DOMAIN -v
    # Start Nginx container
    docker container start nginx
    # Copy files to current directory
    sudo cp /etc/letsencrypt/live/$DOMAIN/fullchain.pem .
    sudo cp /etc/letsencrypt/live/$DOMAIN/privkey.pem .
    # Change the owner and permissions of the files 
    sudo chown ubuntu:ubuntu fullchain.pem privkey.pem
    sudo chmod 644 fullchain.pem privkey.pem   
    docker cp fullchain.pem nginx:/etc/letsencrypt/live/$DOMAIN/
    docker cp privkey.pem nginx:/etc/letsencrypt/live/$DOMAIN/
    # Reload Nginx service
    docker container exec nginx nginx -s reload


# Activate using crontab
# crontab -e
# 0 4 * * 1 sudo /home/ubuntu/nginx/ssl-auto-renew-docker.sh
# *     *     *   *    *        command to be executed
# -     -     -   -    -
# |     |     |   |    |
# |     |     |   |    +----- day of the week (0 - 6) (Sunday=0)
# |     |     |   +------- month (1 - 12)
# |     |     +--------- day of the month (1 - 31)
# |     +----------- hour (0 - 23)
# +------------- min (0 - 59)