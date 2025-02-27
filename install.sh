#!/bin/bash

### BEGIN INIT INFO
# Provides:          ipchanger
# Required-Start:    $local_fs $network $remote_fs
# Required-Stop:     $local_fs $network $remote_fs
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Change IP anonymously using Tor
### END INIT INFO

# Check if the script is run as root
if [ "$EUID" -ne 0 ]; then
    echo "This script must be run as root. Use 'sudo' to execute it."
    exit 1
fi

# Define the path for the init script
INIT_SCRIPT="/etc/init.d/ipchanger"

# Check if the script is already installed
if [ ! -f "$INIT_SCRIPT" ]; then
    echo "Installing the script to $INIT_SCRIPT..."
    cp "$0" "$INIT_SCRIPT"
    chmod +x "$INIT_SCRIPT"
    echo "Script installed. You can now start it using: /etc/init.d/ipchanger start"
    exit 0
fi

# Function to start the service
start() {
    echo "Starting IP Changer service..."
    
    # Check if Tor is installed, if not, install it
    if ! command -v tor &> /dev/null; then
        echo "Tor is not installed. Installing..."
        echo "You can now start it using: /etc/init.d/ipchanger start"
        apt update
        apt install -y tor
        echo "Tor installed."
    fi

    # Start the Tor service if it's not already running
    if ! pgrep -x "tor" > /dev/null; then
        echo "Starting Tor service..."
        systemctl start tor
    fi

    # Infinite loop to change IP
    while true; do
        /etc/init.d/tor reload > /dev/null
        # Get and print the new IP
        #NEW_IP=$(proxychains curl -s http://httpbin.org/ip 2> /dev/null)
        #echo "New IP: $NEW_IP"
        #echo "Waiting 1 second before the next IP change..."
        sleep 1
    done &
    echo $! > /var/run/ipchanger.pid
}

# Function to stop the service
stop() {
    echo "Stopping IP Changer service..."
    if [ -f /var/run/ipchanger.pid ]; then
        kill $(cat /var/run/ipchanger.pid)
        rm /var/run/ipchanger.pid
        echo "Service stopped."
    else
        echo "Service is not running."
    fi
}

case "$1" in
    start)
        start
        ;;
    stop)
        stop
        ;;
    restart)
        stop
        start
        ;;
    *)
        echo "Usage: $0 {start|stop|restart}"
        exit 1
        ;;
esac

exit 0
