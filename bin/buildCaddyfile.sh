#!/bin/bash

#
# This run automaticly on `devenv up`
#
# Troubleshooting: 
#  If you get "declare: -A: invalid option" -> Your bash version is to low.
#
# Development:
#  To speedup testing you can test this script like this:
#  devenv shell
#  bash ./bin/buildCaddyfile.sh
#

# Get the absolute path of the script file e.g. /home/xxx/example.sh
scriptPath=$(readlink -f "$0")

# Get the directory containing the script file e.g. /home/xxx
scriptDir=$(dirname "$scriptPath")

# The generator will write first in this file. When its read it will be moved to $caddyfilePath
caddyfileTmpPath=$scriptDir/../dist/Caddyfile.tmp
caddyfilePath=$scriptDir/../dist/Caddyfile

# Import stuff
source $scriptDir/imports/bashColor.sh
source $scriptDir/imports/functions.sh
source $scriptDir/imports/portMapping.sh
source $scriptDir/imports/projectDirectoriesScan.sh

# This will called at end of the file
init() {
    echoHelloScreen

    readEnvFile
    scanForProjectDirectories
    refreshTmpCaddyfile

    for directory in "${projectDirectories[@]}"; do
        buildCaddyfileForDirectory "$directory"
    done

    moveTmpCaddyfile

    echo ""
    echoWithColor $COLOR_GREEN "🏁 Ready! The router will start soon..."
    echo ""
    echo ""
}

refreshTmpCaddyfile() {
    if [ -f "$caddyfileTmpPath" ]; then
        rm -rf $caddyfileTmpPath
    fi
    touch $caddyfileTmpPath;
}

moveTmpCaddyfile() {
    if [ -f "$caddyfilePath" ]; then
        rm -rf $caddyfilePath
    fi
    mv $caddyfileTmpPath $caddyfilePath
}

buildCaddyfileForDirectory() {
    directory=$1
    echo " "
    echoWithColor $COLOR_GREEN "🏁 Processing directory: $directory"

    echo " - Execute 'devenv info' to extract ENV variables"
    devenvInfoOutput=$(cd $directory && devenv info)

    echo " - Extract environment variables from 'devenv info' output and generate Caddyfile string"
    caddyfileEntry=$(generateCaddyfileLines "$devenvInfoOutput")
    echo "$caddyfileEntry"

    echo " - Write lines to temporary Caddyfile"
    echo "$caddyfileEntry" >> $caddyfileTmpPath
}

generateCaddyfileLines() {
    devenvInfoOutput=$1
    domain=$(extractValueFromDevenvInfoByName "$devenvInfoOutput" "DEVENV_ROUTER_DOMAIN")

    # Loop over the keys of the array
    for key in "${!portMapping[@]}"; do
        # This will hold the "external" port e.g. 80
        routerProccessPort="${portMapping[$key]}"

        # This will hold the "internal" port e.g. 76254
        projectProccessPort=$(extractValueFromDevenvInfoByName "$devenvInfoOutput" "$key")

        # Create a line when projectProccessPort is not 0
        if [ "$projectProccessPort" -ne 0 ]; then
            echo "
                http://$domain:$routerProccessPort {
                    reverse_proxy 127.0.0.1:$projectProccessPort
                }
            "
        fi
    done
}

# Function to extract environment variables containing DEVENV_ROUTER_ from devenv info output
extractValueFromDevenvInfoByName() {
    # Extract the value by name
    value=$(echo "$1" | grep "^- $2:" | awk -F': ' '{print $2}' | tr -d '[:space:]')
    
    # Check if value is empty
    if [ -z "$value" ]; then
        echo 0
    else
        echo "$value"
    fi
}

init