#!/bin/bash
/usr/bin/docker exec -u git -t -w /backup $(docker ps -qf "label=traefik.http.routers.gitea-web.rule=Host(\`gitea.apps.thedutchmc.nl\`)") bash -c '/app/gitea/gitea dump -c /data/gitea/conf/app.ini'
