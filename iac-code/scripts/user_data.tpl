#!/bin/bash

PROJECT_SRC="/tmp"
# Define the variables abd directories array using values passed from Terraform
# shellcheck disable=SC2129
export MONGO_USERNAME="${mongo_username}"
export MONGO_PASSWORD="${mongo_password}"
export KEY_STORE_PASSWORD="${key_store_password}"
export CERTIFICATE="${certificate}"
export PEM_KEY="${pem_key}"
export KEY_STORE_PASSWORD="${key_store_password}"

sudo apt update -y
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources
echo \
   "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
   $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
   sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update -y

# Copy the setup script to the instance
cat << 'EOF' > /tmp/setup_script.sh
${setup_script}
EOF

# Make the script executable and run it
chmod +x /tmp/setup_script.sh
/tmp/setup_script.sh