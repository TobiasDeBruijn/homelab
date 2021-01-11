#!/bin/bash
#Update AlertBot Watcher (server)

#Clear out old remnants, if they exist
rm -rf /tmp/watcher >/dev/null

echo "Creating directories..."
mkdir -p /tmp/watcher

echo "Cloning Watcher..."
git clone https://github.com/Server-AlertBot/Watcher.git /tmp/watcher >/dev/null

echo "Compiling Watcher..."
cd /tmp/watcher
chmod +x gradlew
./gradlew shadowJar

echo "Updating existing Watcher..."
systemctl stop alertbot-watcher

rm /opt/watcher/*.jar
cp /tmp/watcher/build/libs/AlertBot-*.jar /opt/watcher/AlertBot-Watcher.jar

systemctl start alertbot-watcher

echo "Cleaning up..."
rm -rf /tmp/watcher

echo "Done."
