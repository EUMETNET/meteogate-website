# Use the official Apache HTTPD image
FROM httpd:alpine3.24

RUN apk --no-cache add bash && \
    apk --no-cache upgrade && \
    rm -rf /var/cache/apk/*

# Enable the modules for compression/caching config needs
RUN sed -i \
      -e 's/^#\(LoadModule deflate_module .*\)/\1/' \
      -e 's/^#\(LoadModule brotli_module .*\)/\1/' \
      -e 's/^#\(LoadModule expires_module .*\)/\1/' \
      /usr/local/apache2/conf/httpd.conf && \
    echo 'Include conf/extra/compression-caching.conf' >> /usr/local/apache2/conf/httpd.conf

# Copy your project files to the Apache web root directory
COPY index.html main.css notifications.json robots.txt sitemap.xml /usr/local/apache2/htdocs/
COPY faq/ /usr/local/apache2/htdocs/faq/
COPY icons/ /usr/local/apache2/htdocs/icons/
COPY images/ /usr/local/apache2/htdocs/images/
COPY logos/ /usr/local/apache2/htdocs/logos/
COPY fonts/ /usr/local/apache2/htdocs/fonts/
COPY caching.conf /usr/local/apache2/conf/extra/compression-caching.conf

# Ensure proper file permissions (non-root user)
RUN chown -R www-data:www-data /usr/local/apache2/htdocs/ && \
    chmod -R a+r-w+X /usr/local/apache2/htdocs/

# Expose port 80 to access the server
EXPOSE 80
