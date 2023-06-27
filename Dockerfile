FROM nginx:latest
ADD site.tar.gz /usr/share/nginx/html
#COPY nginx.conf /etc/nginx/nginx.conf
COPY fullchain.pem /etc/letsencrypt/live/devops-lab.click/fullchain.pem
COPY privkey.pem /etc/letsencrypt/live/devops-lab.click/privkey.pem
EXPOSE 80