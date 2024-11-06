#!/bin/bash

  PROJECT_SRC="/tmp"

  # Write environment variables
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

  # Create temporary files for the PEM key, certificate, and root certificates
  pem_key_file=$(mktemp)
  certificate_file=$(mktemp)
  root_certificates_file=$(mktemp)

  # Write environment variables to the respective files
  echo "$PEM_KEY" > "$pem_key_file"
  echo "$CERTIFICATE" > "$certificate_file"
  echo "$ROOT_CERTIFICATES" > "$root_certificates_file"

  # Define the output .pfx filename
  output_pfx="certificate.pfx"

  # Generate the .pfx file using openssl
  openssl pkcs12 -export -inkey "$pem_key_file" -in "$certificate_file" -out "$output_pfx" -passout pass:${key_store_password}

    # Clean up temporary files
    rm -f "$pem_key_file" "$certificate_file" "$root_certificates_file"

    echo "PKCS#12 (.pfx) file created as $output_pfx"

# Prepare the directories
create_directory() {
  CONFIG_HOME="${user}/.config"
  BASE_DIR="$CONFIG_HOME/owt"
  declare -a directories=(
      "$BASE_DIR/management_console"
      "$BASE_DIR/management_api"
      "$BASE_DIR/portal"
      "$BASE_DIR/webrtc_agent"
      "$BASE_DIR/analytics_agent"
      "$BASE_DIR/currentapp"
      "$BASE_DIR/analytics_agent/store"
  )
  for dir in "${directories[@]}"; do
      mkdir -p "$dir"
  done
}
# Prepare the certificates
prepare_certificate() {
  SRC_CERT="certificate.pfx"
  CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
  BASE_DIR="$CONFIG_HOME/owt"

declare -a destinations=(
    "$BASE_DIR/management_console/certificate.pfx"
    "$BASE_DIR/management_api/certificate.pfx"
    "$BASE_DIR/portal/certificate.pfx"
    "$BASE_DIR/webrtc_agent/certificate.pfx"
    "$BASE_DIR/analytics_agent/certificate.pfx"
    "$BASE_DIR/currentapp/certificate.pfx"
    "$BASE_DIR/analytics_agent/store/.owt.keystore"
    )
        for dest in "${destinations[@]}"; do
        mkdir -p "$(dirname "$dest")"   # Create the destination directory if it doesn't exist
        cp "$SRC_CERT" "$dest"          # Copy the certificate
        chmod 0755 "$dest"              # Set permissions
        echo "Copied $SRC_CERT to $dest"
    done
}
install_docker(){
      # Add Docker's official GPG key:
      sudo apt-get update
      sudo apt-get install ca-certificates curl
      sudo install -m 0755 -d /etc/apt/keyrings
      sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
      sudo chmod a+r /etc/apt/keyrings/docker.asc

      # Add the repository to Apt sources:
      echo \
        "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
        $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
        sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
      sudo apt-get update
}
create_directory
prepare_certificate
install_docker

# Run the Docker Compose project and capture the output
output=$(docker-compose -f "$PROJECT_SRC/docker-compose.yml" up -d 2>&1)

# Display the results
echo "Docker Compose Output:"
echo "$output" > /tmp/docker.out.log


