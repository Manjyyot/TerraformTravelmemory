#!/bin/bash

set -e  

echo "Starting MongoDB setup..."

sudo apt update -y
sudo apt install -y gnupg curl

if ! dpkg -l | grep -q "mongodb-org"; then
    curl -fsSL https://www.mongodb.org/static/pgp/server-7.0.asc | sudo tee /etc/apt/trusted.gpg.d/mongodb-server-7.0.asc
    echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-7.0.list
    sudo apt update -y
    sudo apt install -y mongodb-org
fi

sudo systemctl start mongod
sudo systemctl enable mongod

sudo chown -R mongodb:mongodb /var/lib/mongodb
sudo chmod -R 755 /var/lib/mongodb

sudo systemctl status mongod --no-pager

echo "MongoDB setup completed!"
