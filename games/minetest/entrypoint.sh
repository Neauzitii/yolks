#!/bin/bash

# Default the TZ environment variable to UTC.
TZ=${TZ:-UTC}
export TZ

# Set environment variable that holds the Internal Docker IP
INTERNAL_IP=$(ip route get 1 | awk '{print $(NF-2);exit}')
export INTERNAL_IP

# Switch to the container's working directory
cd /home/container || exit 1

# Print minetest version
printf "\x1b[34myolks\x1b[0m\x1b[38;5;221m@\x1b[0m\x1b[92mneauzitii\x1b[0m\x1b[97m:\x1b[0m\x1b[38;5;110m~\x1b[0m\x1b[38;5;221m$ \x1b[0mluanti --version\n"
luanti --version

# Replace Startup Variables
MODIFIED_STARTUP=$(echo -e ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g')
echo -e ":/home/container$ ${MODIFIED_STARTUP}"

# Run the Server
eval ${MODIFIED_STARTUP}
