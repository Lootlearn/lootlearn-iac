#!/bin/bash

PROJECT_SRC="/tmp"
# Define the variables abd directories array using values passed from Terraform
echo "Adding variable to shell" >> /tmp/progress.log
# shellcheck disable=SC2129
export MONGO_USERNAME="${mongo_username}"
export MONGO_PASSWORD="${mongo_password}"
export KEY_STORE_PASSWORD="${key_store_password}"
export CERTIFICATE="${certificate}"
export PEM_KEY="${pem_key}"

echo "Create executable file" >> /tmp/progress.log

# Copy the setup script to the instance
cat << 'EOF' > /tmp/setup_script.sh
${setup_script}
EOF

# Make the script executable and run it
chmod +x /tmp/setup_script.sh
/tmp/setup_script.sh