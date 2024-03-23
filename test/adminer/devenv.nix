{ lib, config, ... }:

{
  # This will add a entry to /etc/hosts
  hosts = {
    "devenv-router-test-admin.devenv" = "127.0.0.1";
  };

  # The env variables will hold the Port configuration.
  # In order not to annoy other developers, the standard
  # ports should be stored here. We overwrite the ports
  # in `devenv.local.nix` for your local enviroment.
  # Take a look in `bin/imports/portMapping.sh` for the names.
  env.DEVENV_ROUTER_DOMAIN = lib.mkDefault "devenv-router-test-admin.devenv";
  env.DEVENV_ROUTER_PORT_ADMINER = lib.mkDefault 8080;

  services.adminer = {
    enable = lib.mkDefault true;
    listen = lib.mkDefault "127.0.0.1:${toString (config.env.DEVENV_ROUTER_PORT_ADMINER)}";
  };
}