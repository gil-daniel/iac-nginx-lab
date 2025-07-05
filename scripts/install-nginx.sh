#!/bin/bash

# Update system package lists
sudo apt update -y

# Install NGINX web server
sudo apt install nginx -y

# Create a custom index page showing VM hostname
echo "Instance: $(hostname)" | sudo tee /var/www/html/index.html

# Enable and start NGINX service
sudo systemctl enable nginx
sudo systemctl start nginx

