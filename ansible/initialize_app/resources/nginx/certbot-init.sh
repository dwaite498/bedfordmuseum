#!/bin/sh
certbot certonly --nginx \
    -n \
    -d "$DOMAIN_NAME" \
    -d "www.$DOMAIN_NAME" \
    -d "app.$DOMAIN_NAME" \
    -m "$ADMIN_EMAIL" \
    --agree-tos \
    --no-eff-email
