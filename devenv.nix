{ pkgs, lib, config, ... }:

{
  # Change the Rest-API port for proccess-compose
  env.PC_HTTP_PORT = lib.mkDefault 64625;

  # Build the Caddyfile before "devenv up"
  # "process.before" is to late :/
  enterShell = ''
    bash bin/buildCaddyfile.sh
  '';

  services.caddy.enable = true;
  services.caddy.config = ''
    # The Caddyfile will be generated from enterShell
    import ${config.env.DEVENV_ROOT}/dist/Caddyfile

    # Workaround...
    #
    # Currently the Caddyfile will be read, when there are changes to services.caddy.config
    # If there are no changes devenv/caddy will use a old configuration.
    # Because of this, we use a workaround and replace the following string with a random
    # ###197###
  '';
}
