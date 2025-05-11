#!/bin/bash

# Function to check and update Docker Compose
update_docker_compose() {
  # Check if Docker Compose is installed
  if ! command -v docker-compose &> /dev/null
  then
    echo "Docker Compose is not installed. Installing it..."
    sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
  else
    # Get the current version of Docker Compose
    current_version=$(docker-compose --version | awk '{print $3}' | sed 's/,//')
    echo "Current Docker Compose version: $current_version"

    # Set the minimum required version (1.29.2)
    required_version="1.29.2"

    # Compare current version with required version
    if [ "$current_version" != "$required_version" ]; then
      echo "Updating Docker Compose to version $required_version..."
      sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
      sudo chmod +x /usr/local/bin/docker-compose
    else
      echo "Docker Compose is already at the required version ($required_version)."
    fi
  fi
}

# Check if docker-compose.yaml exists and remove it
if [ -f docker-compose.yaml ]; then
  echo "Removing existing docker-compose.yaml..."
  rm docker-compose.yaml
fi

# Download the latest docker-compose.yaml
echo "Downloading new docker-compose.yaml..."
wget https://raw.githubusercontent.com/9armoude/rosetta_vnc/test/docker-compose.yaml

# Update Docker Compose if needed
update_docker_compose

# Start the container
docker-compose up -d

# Wait for the container to start
sleep 3

# Run Google Chrome in the container
docker exec -d rosetta_container google-chrome-stable --no-sandbox
