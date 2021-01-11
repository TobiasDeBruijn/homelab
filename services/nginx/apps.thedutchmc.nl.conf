#TwitchyCraft Dynmap
server {
        listen 443 ssl;
        listen [::]:443 ssl;

        server_name tc.apps.thedutchmc.nl;

        location / {
                proxy_set_header Host $host;
                proxy_set_header X-Real-IP $remote_addr;
                proxy_set_header X-Forward-For $proxy_add_x_forwarded_for;
                proxy_pass http://192.168.1.42:8123;
                proxy_buffering off;
        }

        ssl_certificate /etc/letsencrypt/live/apps.thedutchmc.nl/fullchain.pem;
        ssl_certificate_key /etc/letsencrypt/live/apps.thedutchmc.nl/privkey.pem;

        # Improve HTTPS performance with session resumption
        ssl_session_cache shared:SSL:10m;
        ssl_session_timeout 10m;

        # Enable server-side protection against BEAST attacks
        ssl_protocols TLSv1.2;
        ssl_prefer_server_ciphers on;
        ssl_ciphers "ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:ECDHE-ECDSA-AES256-SHA384:ECDHE-RSA-AES256-SHA384";

        error_page 500 501 502 503 504 /error/5xx.html;
        error_page 403 404 405 /error/4xx.html;

        location ~ /error/ {
                root /var/www/00-default/;
                autoindex off;
        }
}

#PayTracker
server {
        listen 443 ssl;
        listen [::]:443 ssl;

        server_name pt.apps.thedutchmc.nl;

        root /var/www/paytracker;
        index index.php;

        location ~ \.php$ {
            fastcgi_split_path_info ^(.+\.php)(/.+)$;
            fastcgi_pass   unix:/var/run/php/php7.4-fpm.sock;
            fastcgi_index  index.php;
            fastcgi_param  SCRIPT_FILENAME $document_root$fastcgi_script_name;
            include        fastcgi_params;
        }


        location ~ /\.ht {
                deny all;
        }

        ssl_certificate /etc/letsencrypt/live/apps.thedutchmc.nl/fullchain.pem;
        ssl_certificate_key /etc/letsencrypt/live/apps.thedutchmc.nl/privkey.pem;

        # Improve HTTPS performance with session resumption
        ssl_session_cache shared:SSL:10m;
        ssl_session_timeout 10m;

        # Enable server-side protection against BEAST attacks
        ssl_protocols TLSv1.2;
        ssl_prefer_server_ciphers on;
        ssl_ciphers "ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:ECDHE-ECDSA-AES256-SHA384:ECDHE-RSA-AES256-SHA384";

        error_page 500 501 502 503 504 /error/5xx.html;
        error_page 403 404 405 /error/4xx.html;

        location ~ /error/ {
                root /var/www/00-default/;
                autoindex off;
        }
}

#HomeAssistant
server {
        listen 443 ssl;
        listen [::]:443 ssl;
        server_name homeassistant.apps.thedutchmc.nl;

        location / {
                proxy_set_header Host $host;
                proxy_set_header X-Real-IP $remote_addr;
                proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
                proxy_set_header Upgrade $http_upgrade;
                proxy_set_header Connection upgrade;
                proxy_set_header Accept-Encoding gzip;

                proxy_pass http://192.168.1.201:8123;
        }

        ssl_certificate /etc/letsencrypt/live/apps.thedutchmc.nl/fullchain.pem;
        ssl_certificate_key /etc/letsencrypt/live/apps.thedutchmc.nl/privkey.pem;
        # Improve HTTPS performance with session resumption
        ssl_session_cache shared:SSL:10m;
        ssl_session_timeout 10m;
        # Enable server-side protection against BEAST attacks
        ssl_protocols TLSv1.2;
        ssl_prefer_server_ciphers on;
        ssl_ciphers "ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:ECDHE-ECDSA-AES256-SHA384:ECDHE-RSA-AES256-SHA384";

        error_page 500 501 502 503 504 /error/5xx.html;
        error_page 403 404 405 /error/4xx.html;

        location ~ /error/ {
                root /var/www/00-default/;
                autoindex off;
        }
}

#PHPMyAdmin
server {
        listen 443 ssl;
        listen [::]:443 ssl;
        server_name phpmyadmin.apps.thedutchmc.nl;

        location / {
                proxy_set_header Host $host;
                proxy_set_header X-Real-IP $remote_addr;
                proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
                proxy_set_header Upgrade $http_upgrade;
                proxy_set_header Connection upgrade;
                proxy_set_header Accept-Encoding gzip;

                proxy_pass https://192.168.1.206:443;
        }

        ssl_certificate /etc/letsencrypt/live/apps.thedutchmc.nl/fullchain.pem;
        ssl_certificate_key /etc/letsencrypt/live/apps.thedutchmc.nl/privkey.pem;
        # Improve HTTPS performance with session resumption
        ssl_session_cache shared:SSL:10m;
        ssl_session_timeout 10m;
        # Enable server-side protection against BEAST attacks
        ssl_protocols TLSv1.2;
        ssl_prefer_server_ciphers on;
        ssl_ciphers "ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:ECDHE-ECDSA-AES256-SHA384:ECDHE-RSA-AES256-SHA384";

        error_page 500 501 502 503 504 /error/5xx.html;
        error_page 403 404 405 /error/4xx.html;

        location ~ /error/ {
                root /var/www/00-default/;
                autoindex off;
        }
}

#UniFi Controller @192.168.1.3 (Raspberry pi)
server {
        listen 443 ssl;
        listen [::]:443 ssl;
        server_name unifi.apps.thedutchmc.nl;

        allow 192.168.1.0/24;
        allow 85.144.63.138;

        deny all;

        location / {
                proxy_set_header Host $host;
                proxy_set_header X-Real-IP $remote_addr;
                proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
                proxy_set_header Upgrade $http_upgrade;
                proxy_set_header Connection upgrade;
                proxy_set_header Accept-Encoding gzip;

                proxy_pass https://192.168.1.3:8443;
        }

        ssl_certificate /etc/letsencrypt/live/apps.thedutchmc.nl/fullchain.pem;
        ssl_certificate_key /etc/letsencrypt/live/apps.thedutchmc.nl/privkey.pem;

        error_page 500 501 502 503 504 /error/5xx.html;
        error_page 403 404 405 /error/4xx.html;

        location ~ /error/ {
                root /var/www/00-default/;
                autoindex off;
        }
}

#Traefik
server {
        # SSL configuration
        #
        listen 443 ssl;
        listen [::]:443 ssl;
        server_name *.apps.thedutchmc.nl;

        location / {
                #return 200 "$host$request_uri";
                proxy_set_header Host $host;
                proxy_set_header X-Real-IP $remote_addr;
                proxy_set_header X-Forward-For $proxy_add_x_forwarded_for;
                proxy_pass http://192.168.1.200:8666;
                proxy_set_header Upgrade $http_upgrade;
                proxy_set_header Connection upgrade;
                proxy_set_header Accept-Encoding gzip;
        }

        ssl_certificate /etc/letsencrypt/live/apps.thedutchmc.nl/fullchain.pem;
        ssl_certificate_key /etc/letsencrypt/live/apps.thedutchmc.nl/privkey.pem;
        # Improve HTTPS performance with session resumption
        ssl_session_cache shared:SSL:10m;
        ssl_session_timeout 10m;
        # Enable server-side protection against BEAST attacks
        ssl_protocols TLSv1.2;
        ssl_prefer_server_ciphers on;
        ssl_ciphers "ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:ECDHE-ECDSA-AES256-SHA384:ECDHE-RSA-AES256-SHA384";

        error_page 500 501 502 503 504 /error/5xx.html;
        error_page 403 404 405 /error/4xx.html;

        location ~ /error/ {
                root /var/www/00-default/;
                autoindex off;
        }
}
