#!/bin/bash

#
#
# This is just a workaround...see devenv.nix file
#
#

# Generate a random number between 1 and 1000
random_number=$((RANDOM % 1000 + 1))

# Replace the value between ### markers with the random number in the file
sed -i '' "s/###.*###/###$random_number###/" devenv.nix

devenv up