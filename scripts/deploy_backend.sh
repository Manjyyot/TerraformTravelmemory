#!/bin/bash

# Install Docker if not present
sudo apt update -y
sudo apt install -y docker.io

# Clone the repo if needed
if [ ! -d "TerraformTravelmemory" ]; then
  git clone https://github.com/Manjyyot/TerraformTravelmemory.git
fi

cd TerraformTravelmemory/backend

# Copy .env to backend dir
cp /home/ubuntu/.env .env

# Build & run backend Docker container
sudo docker build -t travel-backend .
sudo docker run -d -p 3001:3001 --env-file .env --name travel-backend travel-backend
