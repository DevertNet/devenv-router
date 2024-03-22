#!/bin/bash

projectDirectories=()
ignoreProjectDirectories=()

scanForProjectDirectories() {
    fillIgnoreProjectDirectories

    echoWithColor $COLOR_GREEN "🏁 Start scanning for devenv projects in $SCAN_DIR."
    echo " Found:"
    while IFS= read -r line; do
        if isIgnoreProjectDirectory "$line"; then
            echoWithColor $COLOR_GREY " - $line (ignore)";
            continue;
        fi

        projectDirectories+=("$line")
        echo " - $line";
    done < <(find $SCAN_DIR -maxdepth $SCAN_DEPTH -name "devenv.nix" -exec dirname {} \;)

    echo ""
    echo " To ignore folders add them in your $(echoWithColor $COLOR_GREY ".env") to $(echoWithColor $COLOR_GREY "SCAN_IGNORE_DIRS")"
    echo ""
    echoWithColor $COLOR_YELLOW "🏁 As next step devenv-router will execute \"devinfo info\" in all directories. This can take some time!"
    read -p " Press Enter to continue..."
}

fillIgnoreProjectDirectories() {
    # Get folders from env.SCAN_IGNORE_DIRS, split them by ";"
    IFS=';' read -ra ignoreProjectDirectories <<< "$SCAN_IGNORE_DIRS"

    # Add devenv-router folder to ignoreProjectDirectories
    ignoreProjectDirectories+=("$(realpath "$scriptDir/..")")
}

isIgnoreProjectDirectory() {
    local string="$1"
    for element in "${ignoreProjectDirectories[@]}"; do
        if [[ "$element" == "$string" ]]; then
            return 0 # String found in array
        fi
    done

    return 1 # String not found in array
}