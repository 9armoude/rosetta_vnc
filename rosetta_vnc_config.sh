#!/bin/bash

# Create and run the container
docker run -d \
  --name rosetta_container \
  --user 0 \
  --shm-size=256m \
  -p 5901:5901 \
  -p 6901:6901 \
  -v headless:/headless \
  vinexborsalino/rosetta_vnc

# Wait a few seconds to ensure the container is fully started
sleep 3

# Run Google Chrome inside the container
docker exec -d rosetta_container google-chrome-stable --no-sandbox
