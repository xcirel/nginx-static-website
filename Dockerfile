FROM nginx:latest
ADD site.tar.gz /usr/share/nginx/html
EXPOSE 80