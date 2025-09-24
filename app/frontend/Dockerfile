FROM nginx:alpine
COPY index.html /usr/share/nginx/html/
RUN chmod 644 /usr/share/nginx/html/index.html
RUN chown nginx:nginx /usr/share/nginx/html/index.html
EXPOSE 80
