let
  nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-23.11";
  pkgs = import nixpkgs { config = {}; overlays = []; };
in

pkgs.mkShellNoCC {
  packages = with pkgs; [
    caddy
  ];

  shellHook =
  ''
    # Absolute path to devenv-router dir
    rootDir=$(dirname "$(realpath "$0")")

    # Absolute path to devenv-router dir
    dataDir="$rootDir/.devenv-router"

    # This will change the storage dir (in this case caddy) to ./.devenv-router directory
    export XDG_DATA_HOME="$dataDir/data"
    export XDG_CONFIG_HOME="$dataDir/config"
  '';
}