#!/bin/bash
sudo apt update -y
sudo apt install -y mongodb
sudo systemctl start mongodb
sudo systemctl enable mongodb
