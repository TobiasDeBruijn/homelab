#!/bin/bash
#Script to install Watch client

HOSTNAME=$(hostname -f)

#Delete potential remnants of previous installations
rm -rf /opt/watch >/dev/null
rm -rf /tmp/watch >/dev/null

echo "Creating directories..."
#Create directories needed for installing and for where the program lvies
mkdir -p /opt/watch
mkdir -p /tmp/watch

echo "Installing dependencies..."
#Update apt and install dependencies
DEBIAN_FRONTEND=noninteractive apt update -qq -y >/dev/null
DEBIAN_FRONTEND=noninteractive apt install -qq -y openjdk-11-jdk-headless git >/dev/null

echo "Cloning Watch..."
#Clone watch from Gituhb
git clone --quiet https://github.com/Server-AlertBot/Watch-Java.git /tmp/watch >/dev/null

echo "Compiling Watch..."
#Compile with Gradle
cd /tmp/watch
chmod +x gradlew
./gradlew shadowJar

echo "Copying files..."
cp /tmp/watch/build/libs/AlertBot-Watch-*.jar /opt/watch/AlertBot-Watch.jar

echo "Creating config file..."
#Create config files
tee -a /opt/watch/alertbot-watch.json << EOT
{
    "name": "HOSTNAME",
    "port": 5555
}
EOT

#Substitute 'HOSTNAME' with this machines hostname
sed -i 's/HOSTNAME/'$HOSTNAME'/' /opt/watch/alertbot-watch.json

echo "Creating Watch service..."
#Delete potential remnants from a previous installation
rm -f /etc/systemd/system/alertbot-watch.service >/dev/null
#Create a service file for Watch
tee -a /etc/systemd/system/alertbot-watch.service << EOT
[Unit]
Description=AlertBot Watch Client

[Service]
WorkingDirectory=/opt/watch
ExecStart=java -jar AlertBot-Watch.jar

[Install]
WantedBy=multi-user.target
EOT

echo "Starting Watch service..."
#start Watch
systemctl daemon-reload
systemctl enable --now alertbot-watch

echo "Cleaning up..."
rm -r /tmp/watch

echo "Done."
