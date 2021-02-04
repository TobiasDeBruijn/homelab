#!/bin/bash

#Dependencies
apt update
apt install -y openjdk-11-jre-headless sudo
dpkg --add-architecture i386; sudo apt update -y; sudo apt install -y curl wget file tar bzip2 gzip unzip bsdmainutils python util-linux ca-certificates binutils bc jq tmux netcat git

#User and server dir
useradd -r -m mcserver
mkdir -p /data/server
mkdir -p /data/scripts

#Permissions
chown -R mcserver:mcserver /data
chmod -R u+rwx /data

cd /data/server

#LinuxGSM
wget -O linuxgsm.sh https://linuxgsm.sh && chmod +x linuxgsm.sh
sudo -u mcserver bash linuxgsm.sh mcserver
sudo -u mcserver bash mcserver auto-install

# LinuxGSM Config
# /data/server/lgsm/config-lgsm/mcserver/mcserver.cfg:
# javaram="2048"
# executable="java -Xmx${javaram}M -jar ${serverfiles}/server.jar"
rm /data/server/lgsm/config-lgsm/mcserver/mcserver.cfg
echo startparameters=\"nogui\" >> /data/server/lgsm/config-lgsm/mcserver/mcserver.cfg
echo javaram=\"2048\" >> /data/server/lgsm/config-lgsm/mcserver/mcserver.cfg
echo executable=\"./server.jar\" >> /data/server/lgsm/config-lgsm/mcserver/mcserver.cfg

#Minecraft config
rm /data/server/serverfiles/server.properties
IP_ADDR=$(ip addr show eth0 | grep "inet\b" | awk '{print $2}' | cut -d/ -f1)
sudo -u mcserver tee -a /data/server/serverfiles/server.properties << EOT
enable-jmx-monitoring=false
rcon.port=25575
level-seed=
gamemode=survival
enable-command-block=true
enable-query=false
generator-settings=
level-name=world
motd=A Minecraft Server
query.port=25565
pvp=true
generate-structures=true
difficulty=hard
network-compression-threshold=-1
max-tick-time=60000
use-native-transport=true
max-players=20
online-mode=false
enable-status=true
allow-flight=false
broadcast-rcon-to-ops=true
view-distance=10
max-build-height=256
server-ip=IP_ADDR
allow-nether=true
server-port=25565
sync-chunk-writes=true
enable-rcon=false
op-permission-level=4
prevent-proxy-connections=false
resource-pack=
entity-broadcast-range-percentage=100
rcon.password=
player-idle-timeout=0
force-gamemode=false
debug=false
rate-limit=0
hardcore=false
white-list=false
broadcast-console-to-ops=true
spawn-npcs=true
spawn-animals=true
snooper-enabled=true
function-permission-level=2
level-type=default
text-filtering-config=
spawn-monsters=true
enforce-whitelist=false
spawn-protection=0
resource-pack-sha1=
max-world-size=29999984
EOT

#Replace IP in server.properties
sed -i 's/IP_ADDR/'$IP_ADDR'/' /data/server/serverfiles/server.properties

#Spigot Config
rm /data/server/serverfiles/spigot.yml
sudo -u mcserver tee -a /data/server/serverfiles/spigot.yml << EOT 
config-version: 12
settings:
  save-user-cache-on-stop-only: false
  sample-count: 12
  bungeecord: true
  player-shuffle: 0
  user-cache-size: 1000
  moved-wrongly-threshold: 0.0625
  moved-too-quickly-multiplier: 10.0
  log-villager-deaths: true
  timeout-time: 60
  restart-on-crash: true
  restart-script: ./start.sh
  netty-threads: 4
  debug: false
  attribute:
    maxHealth:
      max: 2048.0
    movementSpeed:
      max: 2048.0
    attackDamage:
      max: 2048.0
messages:
  whitelist: You are not whitelisted on this server. Please contact an Admin.
  unknown-command: Unknown command. Type "/help" for help.
  server-full: The server is full!
  outdated-client: Outdated client! Please use {0}
  outdated-server: Outdated server! I'm still on {0}
  restart: Server is restarting
commands:
  log: true
  spam-exclusions:
  - /skill
  silent-commandblock-console: false
  replace-commands:
  - setblock
  - summon
  - testforblock
  - tellraw
  tab-complete: 0
  send-namespaced: true
advancements:
  disable-saving: false
  disabled:
  - minecraft:story/disabled
stats:
  disable-saving: false
  forced-stats: {}
world-settings:
  default:
    seed-bastion: 30084232
    seed-fortress: 30084232
    seed-mansion: 10387319
    seed-fossil: 14357921
    seed-portal: 34222645
    seed-endcity: 10387313
    end-portal-sound-radius: 0
    verbose: true
    mob-spawn-range: 8
    hopper-amount: 1
    dragon-death-sound-radius: 0
    seed-village: 10387312
    seed-desert: 14357617
    seed-igloo: 14357618
    seed-jungle: 14357619
    seed-swamp: 14357620
    seed-monument: 10387313
    seed-shipwreck: 165745295
    seed-ocean: 14357621
    seed-outpost: 165745296
    seed-slime: 987234911
    max-tnt-per-tick: 100
    view-distance: default
    enable-zombie-pigmen-portal-spawns: true
    item-despawn-rate: 6000
    arrow-despawn-rate: 1200
    trident-despawn-rate: 1200
    wither-spawn-sound-radius: 0
    hanging-tick-frequency: 100
    zombie-aggressive-towards-villager: true
    nerf-spawner-mobs: false
    max-entity-collisions: 8
    merge-radius:
      exp: 3.0
      item: 2.5
    growth:
      cactus-modifier: 100
      cane-modifier: 100
      melon-modifier: 100
      mushroom-modifier: 100
      pumpkin-modifier: 100
      sapling-modifier: 100
      beetroot-modifier: 100
      carrot-modifier: 100
      potato-modifier: 100
      wheat-modifier: 100
      netherwart-modifier: 100
      vine-modifier: 100
      cocoa-modifier: 100
      bamboo-modifier: 100
      sweetberry-modifier: 100
      kelp-modifier: 100
    entity-activation-range:
      villagers: 32
      flying-monsters: 32
      villagers-work-immunity-after: 100
      villagers-work-immunity-for: 20
      villagers-active-for-panic: true
      animals: 32
      monsters: 32
      raiders: 48
      misc: 16
      water: 16
      tick-inactive-villagers: true
      wake-up-inactive:
        animals-max-per-tick: 4
        animals-every: 1200
        animals-for: 100
        monsters-max-per-tick: 8
        monsters-every: 400
        monsters-for: 100
        villagers-max-per-tick: 4
        villagers-every: 600
        villagers-for: 100
        flying-monsters-max-per-tick: 8
        flying-monsters-every: 200
        flying-monsters-for: 100
    entity-tracking-range:
      players: 48
      animals: 48
      monsters: 48
      misc: 32
      other: 64
    ticks-per:
      hopper-transfer: 8
      hopper-check: 1
    hunger:
      jump-walk-exhaustion: 0.05
      jump-sprint-exhaustion: 0.2
      combat-exhaustion: 0.1
      regen-exhaustion: 6.0
      swim-multiplier: 0.01
      sprint-multiplier: 0.1
      other-multiplier: 0.0
    max-tick-time:
      tile: 50
      entity: 50
    squid-spawn-range:
      min: 45.0
players:
  disable-saving: false
EOT

#Build the spigot jar
mkdir -p /data/spigot
cd /data/spigot
wget https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar -O /data/spigot/BuildTools.jar
java -jar /data/spigot/BuildTools.jar
cp /data/spigot/spigot-*.jar /data/server/serverfiles/server.jar
chown mcserver:mcserver /data/server/serverfiles/server.jar
chmod u+rwx /data/server/serverfiles/server.jar

#Cleanup
rm -r /data/spigot
rm /data/server/serverfiles/minecraft_server.jar

#Automatically start the server at boot
tee -a /etc/systemd/system/start_server.service << EOT
[Unit]
Description=LinuxGSM Server
After=network-online.target
Wants=network-online.target
[Service]
Type=forking
User=mcserver
WorkingDirectory=/data/server
ExecStart=/data/server/mcserver start
ExecStop=/data/server/mcserver stop
Restart=no
RemainAfterExit=yes
[Install]
WantedBy=multi-user.target
EOT

systemctl daemon-reload
systemctl enable --now start_server
