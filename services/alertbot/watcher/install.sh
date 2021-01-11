#!/bin/bash
#Install AlertBot Watcher

rm -rf /opt/watcher >/dev/null
rm -rf /tmp/watcher >/dev/null

echo "Creating directories..."
mkdir -p /opt/watcher
mkdir -p /tmp/watcher

echo "Installing dependencies..."
DEBIAN_FRONTEND=noninteractive apt update -qq -y >/dev/null
DEBIAN_FRONTEND=noninteractive apt install -qq -y openjdk-11-jdk-headless git >/dev/null

echo "Cloning Watcher..."
git clone --quiet https://github.com/Server-AlertBot/Watcher.git /tmp/watcher >/dev/null

echo "Compiling Watcher..."
cd /tmp/watcher
chmod +x gradlew
./gradlew shadowJar

echo "Copying files..."
cp /tmp/watcher/build/libs/AlertBot-*.jar /opt/watcher/AlertBot-Watcher.jar

echo "Creating config file..."
tee -a /opt/watcher/alertbot.json << EOT
{
    "config": {
        "watchInterval": 30,
        "enableTwitter": false,
        "twitterBearer": "",
        "websiteUrl": "",
        "enableDiscord": true,
        "botToken": "",
        "alertChannelId": ""
    },
    "watch": [
    ]
}
EOT

echo "Creating Watcher service..."
rm -f /etc/systemd/system/alertbot-watcher.service >/dev/null

tee -a /etc/systemd/system/alertbot-watcher.service << EOT
[Unit]
Description=AlertBot Watcher (Server)

[Service]
WorkingDirectory=/opt/watcher
ExecStart=java -jar AlertBot-Watcher.jar

[Install]
WantedBy=multi-user.target
EOT

echo "Cleaning up..."
rm -r /tmp/watcher

cat << EOT
Installation Complete
---------------------
You should no proceed to configure AlertBot-Watcher. The config file is found at /opt/watcher/alertbot.json

Watch-nodes should be in the format of "hostname-or-ip:port"

After configuration you can start AlertBot-Watcher with: systemctl start alertbot-watcher

Support is offered in my Discord here: https://discord.com/invite/BrhNg7z
EOT
