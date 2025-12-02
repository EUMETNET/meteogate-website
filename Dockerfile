# Use the official Apache HTTPD image
FROM httpd:alpine3.22

# Copy the contents of your local project folder into the Apache server's document root
COPY . /usr/local/apache2/htdocs/

RUN apk --no-cache add \
    bash \
    && rm -rf /var/cache/apk/*

# Copy your project files to the Apache web root directory
COPY . /usr/local/apache2/htdocs/

# Ensure proper file permissions (non-root user)
RUN chown -R www-data:www-data /usr/local/apache2/htdocs/ \
    && chmod -R 755 /usr/local/apache2/htdocs/

# Expose port 80 to access the server
EXPOSE 80
