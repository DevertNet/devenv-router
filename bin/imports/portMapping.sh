#!/bin/bash

# Declare a multidimensional associative array
declare -A portMapping

# Set port the mapping
# key: Name of the env variable inside the projects
# value: Port of the routed domain e.g. example.devenv:8080 -> 127.0.0.1:65626
portMapping["DEVENV_ROUTER_PORT_HTTP"]=80
portMapping["DEVENV_ROUTER_PORT_HTTPS"]=443
portMapping["DEVENV_ROUTER_PORT_ADMINER"]=8080
portMapping["DEVENV_ROUTER_PORT_RABBITMQ_UI"]=15672
portMapping["DEVENV_ROUTER_PORT_MAILPIT_UI"]=8025
portMapping["DEVENV_ROUTER_PORT_MINIO_UI"]=9001


# Declare a multidimensional associative array
declare -A protocolMapping

# Set protocol mapping
# key: Name of the env variable inside the projects
# value: Protocol for the routed domain e.g. https://example.devenv:443 -> 127.0.0.1:65626
protocolMapping["DEVENV_ROUTER_PORT_HTTP"]="http://"
protocolMapping["DEVENV_ROUTER_PORT_HTTPS"]="https://"
protocolMapping["DEVENV_ROUTER_PORT_ADMINER"]="http://"
protocolMapping["DEVENV_ROUTER_PORT_RABBITMQ_UI"]="http://"
protocolMapping["DEVENV_ROUTER_PORT_MAILPIT_UI"]="http://"
protocolMapping["DEVENV_ROUTER_PORT_MINIO_UI"]="http://"
