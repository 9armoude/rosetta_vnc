#!/bin/bash

# Check if docker-compose.yaml exists and remove it if so
if [ -f docker-compose.yaml ]; then
  echo "Removing existing docker-compose.yaml..."
  rm docker-compose.yaml
fi

# Download the latest docker-compose.yaml from GitHub
echo "Downloading new docker-compose.yaml..."
wget https://raw.githubusercontent.com/9armoude/rosetta_vnc/test/docker-compose.yaml

# Start the container
docker-compose up -d

# Wait a few seconds to ensure the container is fully started
sleep 3

# Run Google Chrome inside the container
docker exec -d rosetta_container google-chrome-stable --no-sandbox
