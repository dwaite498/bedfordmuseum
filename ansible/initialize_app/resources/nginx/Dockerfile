FROM nginx
RUN apt-get update && apt-get install -yq certbot python-certbot-nginx
COPY nginx.conf /etc/nginx/nginx.conf
COPY default.conf.template /default.conf.template
COPY htpasswd /etc/apache2/.htpasswd
COPY certbot-init.sh /scripts/certbot-init.sh
COPY certbot-renew.sh /scripts/certbot-renew.sh
RUN chmod +x /scripts/*.sh
ENV PATH /scripts:$PATH
