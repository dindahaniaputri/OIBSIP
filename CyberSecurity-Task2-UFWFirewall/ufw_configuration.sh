#!/bin/bash

# UFW Firewall Configuration
# Oasis Infobyte Cyber Security Internship - Task 2

echo "Starting UFW firewall configuration..."

# Enable UFW
sudo ufw --force enable

# Allow SSH
sudo ufw allow ssh

# Deny HTTP
sudo ufw deny http

# Allow HTTPS
sudo ufw allow https

# Deny FTP
sudo ufw deny ftp

# Display firewall status
sudo ufw status verbose

echo "UFW firewall configuration completed."
