#!/bin/bash

# Update system packages
sudo apt update -y

# Install MongoDB
sudo apt install -y mongodb

# Enable and start MongoDB service
sudo systemctl enable mongodb
sudo systemctl start mongodb

# Verify MongoDB is running
sudo systemctl status mongodb --no-pager

# Allow remote connections (Optional: If MongoDB should be accessed from other instances)
sudo sed -i 's/^#bindIp: 127.0.0.1/bindIp: 0.0.0.0/' /etc/mongod.conf

# Restart MongoDB service to apply changes
sudo systemctl restart mongodb
