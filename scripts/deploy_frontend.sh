#!/bin/bash

sudo apt update -y
sudo apt install -y docker.io

# Clone the repo if needed
if [ ! -d "TerraformTravelmemory" ]; then
  git clone https://github.com/Manjyyot/TerraformTravelmemory.git
fi

cd TerraformTravelmemory/frontend

# Build frontend and serve with nginx container
sudo docker build -t travel-frontend .
sudo docker run -d -p 80:80 --name travel-frontend travel-frontend
