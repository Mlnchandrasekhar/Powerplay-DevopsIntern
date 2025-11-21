FROM nginx:alpine3.22

RUN rm -rf /var/www/nginx/html/*

RUN rm -rf /etc/nginx/nginx.conf

COPY nginx.conf /etc/nginx/nginx.conf

COPY index.html /var/www/nginx/html/

CMD ["nginx", "-g", "daemon off;"]

