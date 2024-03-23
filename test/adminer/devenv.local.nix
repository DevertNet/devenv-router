{ lib, ... }:

{
  # Set an individual port per project for each
  # service. The port must not be used in any other project.
  env.DEVENV_ROUTER_PORT_ADMINER = lib.mkForce 45343;

  # Change the Rest-API port for proccess-compose
  env.PC_HTTP_PORT = 64635;
}