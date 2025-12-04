# Use the official Apache HTTPD image
FROM httpd:alpine3.22

RUN apk --no-cache add bash && \
    apk --no-cache upgrade && \
    rm -rf /var/cache/apk/*

# Copy your project files to the Apache web root directory
COPY index.html main.css /usr/local/apache2/htdocs/
COPY icons/ /usr/local/apache2/htdocs/icons/
COPY images/ /usr/local/apache2/htdocs/images/
COPY logos/ /usr/local/apache2/htdocs/logos/

# Ensure proper file permissions (non-root user)
RUN chown -R www-data:www-data /usr/local/apache2/htdocs/ && \
    chmod -R a+r-w+X /usr/local/apache2/htdocs/

# Expose port 80 to access the server
EXPOSE 80
