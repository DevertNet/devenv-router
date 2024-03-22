#!/bin/bash

# Declare a multidimensional associative array
declare -A portMapping

# Set the mapping
# key: Name of the env variable inside the projects
# value: Port of the routed domain e.g. example.devenv:8080 -> 127.0.0.1:65626
portMapping["DEVENV_ROUTER_PORT_HTTP"]=80
portMapping["DEVENV_ROUTER_PORT_HTTPS"]=443
portMapping["DEVENV_ROUTER_PORT_ADMINER"]=8080
