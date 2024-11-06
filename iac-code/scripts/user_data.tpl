#!/bin/bash

PROJECT_SRC="/tmp"
# Define the variables abd directories array using values passed from Terraform

# shellcheck disable=SC2129
echo "export MONGO_USERNAME=\"${mongo_username}\"" >> ~/.bashrc
echo "export MONGO_PASSWORD=\"${mongo_password}\"" >> ~/.bashrc
echo "export PEM_KEY=\"${pem_key}\"" >> ~/.bashrc
echo "export CERTIFICATE=\"${certificate}\"" >> ~/.bashrc
echo "export ROOT_CERTIFICATES=\"${root_certificate}\"" >> ~/.bashrc
# shellcheck source=${HOME}/.bashrc
source ~/.bashrc

# Check that necessary environment variables are set
if [[ -z "$PEM_KEY" || -z "$CERTIFICATE" || -z "$ROOT_CERTIFICATES" || -z "$MONGO_PASSWORD" || -z "$MONGO_USERNAME" ]]; then
  echo "Error: PEM_KEY, CERTIFICATE, ROOT_CERTIFICATES, MONGO_USERNAME and MONGO_PASSWORD environment variables must be set." > /tmp/variable_error.log
  exit 1
fi

# Copy the setup script to the instance
cat << 'EOF' > /tmp/setup_script.sh
${file("${path.module}/scripts/setup_script.sh")}
EOF

# Make the script executable and run it
chmod +x /tmp/setup_script.sh
/tmp/setup_script.sh