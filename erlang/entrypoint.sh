# Default the TZ environment variable to UTC.
TZ=${TZ:-UTC}
export TZ

# Set environment variable that holds the Internal Docker IP
INTERNAL_IP=$(ip route get 1 | awk '{print $(NF-2);exit}')
export INTERNAL_IP

# Switch to the container's working directory
cd /home/container || exit 1

# Print Erlang's version
printf "\x1b[34myolks\x1b[0m\x1b[38;5;221m@\x1b[0m\x1b[92mneauzitii\x1b[0m\x1b[97m:\x1b[0m\x1b[38;5;110m~\x1b[0m\x1b[38;5;221m$ \x1b[0merl -noshell -eval 'erlang:display(erlang:system_info(system_version))' -eval 'init:stop()'\n"
erl -noshell -eval 'erlang:display(erlang:system_info(system_version))' -eval 'init:stop()'

# Convert all of the "{{VARIABLE}}" parts of the command into the expected shell
# variable format of "${VARIABLE}" before evaluating the string and automatically
# replacing the values.
PARSED=$(echo "${STARTUP}" | sed -e 's/{{/${/g' -e 's/}}/}/g' | eval echo "$(cat -)")

# Display the command we're running in the output, and then execute it with the env
# from the container itself.
printf "\x1b[34myolks\x1b[0m\x1b[38;5;221m@\x1b[0m\x1b[92mneauzitii\x1b[0m\x1b[97m:\x1b[0m\x1b[38;5;110m~\x1b[0m\x1b[38;5;221m$ \x1b[0m%s\n" "$PARSED"
# shellcheck disable=SC2086
exec env ${PARSED}
