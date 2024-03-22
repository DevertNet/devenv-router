#!/bin/bash

# Read the values from the .env file
readEnvFile() {
    if [ -f "$scriptDir/../.env" ]; then
        source "$scriptDir/../.env"
    else
        echo "Error: .env file not found."
        exit 1
    fi
}