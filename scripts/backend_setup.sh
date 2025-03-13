#!/bin/bash

set -e  # Exit immediately if a command fails

echo "Starting Backend setup..."

# Update system packages
sudo apt update -y
sudo apt install -y git curl unzip

# Install Node.js & npm
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt install -y nodejs

# Clone the backend repository
cd ~
if [ -d "TerraformTravelmemory" ]; then
    cd TerraformTravelmemory && git pull
else
    git clone https://github.com/Manjyyot/TerraformTravelmemory.git
    cd TerraformTravelmemory
fi

# Navigate to the backend directory
cd backend

# Install backend dependencies
npm install

# Ensure the .env file exists
if [ ! -f ".env" ]; then
    cat <<EOF > .env
MONGO_URI=mongodb://<MONGODB_IP>:27017/travelmemory
PORT=5000
EOF
    echo ".env file created"
fi

# Start backend server in background
nohup npm run start > backend.log 2>&1 &

echo "Backend setup completed!"
