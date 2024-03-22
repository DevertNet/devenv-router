{ pkgs, config, ... }:

{
  enterShell = ''
    bash bin/buildCaddyfile.sh
  '';

  services.caddy.enable = true;
  services.caddy.config = ''
    # The Caddyfile will be generated from enterShell
    import ${config.env.DEVENV_ROOT}/dist/Caddyfile
    # Important comment, we need a line break here...
  '';
}
