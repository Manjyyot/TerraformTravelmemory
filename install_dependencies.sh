#!/bin/bash

set -e

# Function to check if a package is installed, and install it if not
install_package() {
    local package_name=$1
    local install_cmd=$2
    if ! command -v "$package_name" >/dev/null 2>&1; then
        echo "Installing $package_name..."
        eval "$install_cmd"
    else
        echo "$package_name is already installed."
    fi
}

# Install unzip if not present
install_unzip() {
    sudo apt update
    sudo apt install unzip -y
}

# Install AWS CLI
install_aws_cli() {
    # Correct AWS CLI v2 download link
    echo "Downloading AWS CLI..."
    wget https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip -O awscliv2.zip

    # Check if the file is downloaded correctly
    if [ ! -f "awscliv2.zip" ] || [ $(stat -c %s "awscliv2.zip") -lt 10000 ]; then
        echo "AWS CLI zip file is missing or too small. Exiting."
        exit 1
    fi

    # Unzip and install
    echo "Unzipping AWS CLI..."
    unzip awscliv2.zip
    sudo ./aws/install
}

# Install Terraform (latest version)
install_terraform() {
    echo "Installing the HashiCorp GPG key."
    sudo apt-get update && sudo apt-get install -y gnupg software-properties-common wget lsb-release

    wget -q -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null

    echo "Adding the HashiCorp repository."
    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list

    sudo apt-get update && sudo apt-get install -y terraform || {
        echo "Terraform installation failed. Exiting."
        exit 1
    }

    echo "Terraform installation completed successfully."
}

# Install Git
install_git() {
    sudo apt update
    sudo apt install git -y
}

# Install Jenkins
install_jenkins() {
    echo "Downloading Jenkins WAR file..."
    sudo wget -q -O /opt/jenkins.war https://get.jenkins.io/war-stable/2.492.1/jenkins.war

    echo "Creating Jenkins service..."
    cat <<EOF | sudo tee /etc/systemd/system/jenkins.service
[Unit]
Description=Jenkins
After=network.target

[Service]
ExecStart=/usr/bin/java -jar /opt/jenkins.war
User=root
Restart=always
LimitNOFILE=8192

[Install]
WantedBy=multi-user.target
EOF

    echo "Reloading systemd, starting Jenkins service..."
    sudo systemctl daemon-reload
    sudo systemctl start jenkins
    sudo systemctl enable jenkins

    echo "Jenkins installed and running on port 8080."
}

# Check if Java 17 is installed, else install it
install_java() {
    java_version=$(java -version 2>&1 | head -n 1 | cut -d '"' -f 2)
    if [[ "$java_version" != "17"* ]]; then
        echo "Java 17 is not installed. Installing Java 17..."
        sudo apt update
        sudo apt install openjdk-17-jdk -y
    else
        echo "Java 17 is already installed."
    fi
}

# Check and install all necessary dependencies
check_and_install_dependencies() {
    install_package "unzip" "install_unzip"
    install_package "aws" "install_aws_cli"
    install_package "git" "install_git"
    install_java
    install_terraform
    install_jenkins
}

# Configure AWS CLI
configure_aws_cli() {
    aws configure
}

# Start the setup process
echo "Starting dependency installation..."
check_and_install_dependencies
echo "Configuring AWS CLI..."
configure_aws_cli

echo "Setup complete!"
