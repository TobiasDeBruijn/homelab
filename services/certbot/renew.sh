#!/bin/bash
# See: https://certbot-dns-cloudflare.readthedocs.io/en/stable/

NOW=$(date +"%d-$m-%Y-%H-%M-%S")

echo "---------------------------------------"
echo "Renewing certificates. It is now ${NOW}"
echo "---------------------------------------"

certbot renew --dns-cloudflare --dns-cloudflare-credentials /root/.secrets/cloudflare_token.ini
nginx -s reload

echo "----------------"
echo "Renewal complete"
echo "----------------"
printf "\n"
