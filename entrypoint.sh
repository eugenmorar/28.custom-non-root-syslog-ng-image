#!/bin/bash
set -e


# First command
echo "Uncomment SYSLOGNG_OPTS..."
# Your first command here, e.g., initializing something
sudo sed -i 's/^# *\(SYSLOGNG_OPTS="--no-caps"\)/\1/' /etc/default/syslog-ng

# Second command
echo "Start syslog-ng daemon..."
sudo syslog-ng -F

# Execute the provided command (if any)
exec "$@"
