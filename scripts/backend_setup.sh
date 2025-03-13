#!/bin/bash

set -e  

echo "Starting Backend setup..."

sudo apt update -y
sudo apt install -y nodejs npm git

cd ~
if [ -d "TerraformTravelmemory" ]; then
    cd TerraformTravelmemory && git pull
else
    git clone https://github.com/Manjyyot/TerraformTravelmemory.git
    cd TerraformTravelmemory
fi

cd backend

npm install

echo "PORT=5000" > .env
MONGO_IP=$(terraform output -raw mongodb_instance_ip)
echo "MONGO_URI=mongodb://$MONGO_IP:27017/travelmemory" >> .env

node server.js &

echo "Backend setup completed!"
