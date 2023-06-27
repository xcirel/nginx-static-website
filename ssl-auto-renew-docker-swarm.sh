#!/bin/bash
# This script will auto-renew the SSL certificate for the domain using certbot and nginx
# version 1.1


DOMAIN="webserver.devops-lab.click"


docker service ls --format {{.Name}} | grep nginx
docker container ls --format {{.Names}} | grep nginx

# 2. Atribuir o valor das váriaveis
export nginx_service=$(docker service ls --format {{.Name}} | grep nginx)
export nginx_container=$(docker container ls --format {{.Names}} | grep nginx)
# 3. Validar imprimindo o valor da variável
echo "Variável service" $nginx_service
echo "Variável container" $nginx_container

docker service scale $nginx_service=0

# Wait for 10 seconds
sleep 10

# Renew the certificate
#sudo certbot certonly --force-renewal --non-interactive --agree-tos --standalone -d $DOMAIN -v

# Copy files to current directory
sudo cp /etc/letsencrypt/live/$DOMAIN/fullchain.pem .
sudo cp /etc/letsencrypt/live/$DOMAIN/privkey.pem .
# Change the owner and permissions of the files 
sudo chown ubuntu:ubuntu fullchain.pem privkey.pem
sudo chmod 644 fullchain.pem privkey.pem 
# Copy files to container  
docker cp fullchain.pem $nginx_container:/etc/letsencrypt/live/$DOMAIN/
docker cp privkey.pem $nginx_container:/etc/letsencrypt/live/$DOMAIN/

docker service scale $nginx_service=1

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
