#!/bin/bash

projectDirectories=()

scanForProjectDirectories() {
    projectDirectories+=("/Users/leon/htdocs/adac/shopware6")
    echo "$projectDirectories"
    return

    echo "Start scanning for devenv projects in $SCAN_DIR."
    echo "Found:"
    while IFS= read -r line; do
        projectDirectories+=("$line")
        echo "- $line";
    done < <(find $SCAN_DIR -maxdepth $SCAN_DEPTH -name "devenv.nix" -exec dirname {} \;)
}