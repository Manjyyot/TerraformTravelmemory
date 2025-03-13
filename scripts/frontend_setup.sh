#!/bin/bash

set -e  

echo "Starting Frontend setup..."

sudo apt update -y
sudo apt install -y nodejs npm git nginx

sudo systemctl start nginx
sudo systemctl enable nginx

sudo mkdir -p /var/www/html
sudo chmod -R 755 /var/www/html

cd ~
if [ -d "TerraformTravelmemory" ]; then
    cd TerraformTravelmemory && git pull
else
    git clone https://github.com/Manjyyot/TerraformTravelmemory.git
    cd TerraformTravelmemory
fi

cd frontend

npm install --legacy-peer-deps --force
npm run build

sudo cp -r build/* /var/www/html/
sudo systemctl restart nginx

echo "Frontend setup completed!"
