#!/bin/bash

# Define colors using ANSI escape sequences
COLOR_RED='\033[0;31m'
COLOR_GREEN='\033[0;32m'
COLOR_YELLOW='\033[0;33m'
COLOR_GREY='\033[0;90m'
COLOR_NC='\033[0m' # No Color

echoWithColor() {
    echo -e "$1$2${COLOR_NC}"
}

echoHelloScreen() {
    echo ""
    echo ""
    echo "     _                                                  _            "
    echo "    | |                                                | |           "
    echo "  __| | _____   _____ _ ____   ________ _ __ ___  _   _| |_ ___ _ __ "
    echo " / _\` |/ _ \ \ / / _ \ '_ \ \ / /______| '__/ _ \| | | | __/ _ \ '__|"
    echo "| (_| |  __/\ V /  __/ | | \ V /       | | | (_) | |_| | ||  __/ |   "
    echo " \__,_|\___| \_/ \___|_| |_|\_/        |_|  \___/ \__,_|\__\___|_|   "
    echo ""
    echo ""
}