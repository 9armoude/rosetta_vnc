#!/bin/bash

# Create and run the container
docker-compose up -d

# Wait a few seconds to ensure the container is fully started
sleep 3

# Run Google Chrome inside the container
docker exec -d rosetta_container google-chrome-stable --no-sandbox
