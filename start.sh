#!/bin/bash

echo "Start devenv-router..."
nix-shell --run "bash ./bin/buildCaddyfile.sh && caddy run --config dist/Caddyfile" --verbose