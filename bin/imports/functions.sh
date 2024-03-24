#!/bin/bash

# Read the values from the .env file
readEnvFile() {
    if [ -f "$scriptDir/../.env" ]; then
        source "$scriptDir/../.env"
    else
        echoWithColor $COLOR_RED "Error: .env file not found."
        exit 1
    fi
}

askYesNo() {
    while true; do
        read -p "$1 (y/n): " yn
        case $yn in
            [Yy]* ) return 0;; # Return 0 for "yes"
            [Nn]* ) return 1;; # Return 1 for "no"
            * ) echo "Please answer yes or no.";;
        esac
    done
}
