#!/bin/bash

# Check if docker-compose.yaml exists and remove it
if [ -f docker-compose.yaml ]; then
  echo "Removing existing docker-compose.yaml..."
  rm docker-compose.yaml
fi

# Download the latest docker-compose.yaml
echo "Downloading new docker-compose.yaml..."
wget https://raw.githubusercontent.com/9armoude/rosetta_vnc/test/docker-compose.yaml

# Remove 'version:' line
#sed -i '/^version:/d' docker-compose.yaml

# Also remove leading 2 spaces from 'services:' line if it exists
#sed -i '/^services:/d' docker-compose.yaml
#sed -i 's/^  //' docker-compose.yaml

# Start the container
docker-compose up -d

# Wait for the container to start
sleep 3

# Run Google Chrome in the container
docker exec -d rosetta_container google-chrome-stable --no-sandbox
