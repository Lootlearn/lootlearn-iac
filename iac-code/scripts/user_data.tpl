#!/bin/bash

PROJECT_SRC="/tmp"
# Define the variables abd directories array using values passed from Terraform

# shellcheck disable=SC2129
echo "export MONGO_USERNAME=\"${mongo_username}\"" >> ~/.bashrc
echo "export MONGO_PASSWORD=\"${mongo_password}\"" >> ~/.bashrc
echo "export PEM_KEY=\"${pem_key}\"" >> ~/.bashrc
echo "export CERTIFICATE=\"${certificate}\"" >> ~/.bashrc
source ~/.bashrc


# Copy the setup script to the instance
cat << 'EOF' > /tmp/setup_script.sh
${setup_script}
EOF

# Make the script executable and run it
chmod +x /tmp/setup_script.sh
/tmp/setup_script.sh