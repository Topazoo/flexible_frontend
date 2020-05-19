FROM httpd:2.4
COPY app/build/web /usr/local/apache2/htdocs/
EXPOSE 80