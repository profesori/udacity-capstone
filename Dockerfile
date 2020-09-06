FROM nginx:latest
COPY app/index.html /usr/share/nginx/html
EXPOSE 80
