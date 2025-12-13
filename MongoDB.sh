#!/bin/bash
# Pritunl repo
sudo tee /etc/apt/sources.list.d/pritunl.list << EOF
deb https://repo.pritunl.com/stable/apt $(lsb_release -sc) main
EOF

# MongoDB repo (Pritunl требует MongoDB 6+)
sudo tee /etc/apt/sources.list.d/mongodb-org.list << EOF
deb https://repo.mongodb.org/apt/ubuntu $(lsb_release -sc)/mongodb-org/7.0 multiverse
EOF

# Ключи
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com --recv 7568D9BB55FF9E5287D586017AE645C0CF8E292A
wget -qO - https://www.mongodb.org/static/pgp/server-7.0.asc | sudo apt-key add -

sudo apt update
sudo apt install pritunl mongodb-org -y

sudo systemctl start pritunl mongodb
sudo systemctl enable pritunl mongodb

sudo pritunl setup-key
