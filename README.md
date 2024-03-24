# 🌐 devenv-router

With this project it is possible to start several devenv projects and use them under the same ports with different hostnames.  
Example:

- example.devenv:80
- nextproject.devenv:80

## ❓ How does it work?

The services (e.g. Caddy, MySql etc.) of your projects will be started under different ports.
devenv-router automatically reads the ports and starts a Caddy server with a reverse proxy.
For example.devenv:80 is routed to 127.0.0.1:83723. In this case, 83723 is the HTTP port of the example project.

## 🔑 Restrictions

Only HTTP/s connections with the same ports can be routed. TCP connections (e.g. MySql) are only based on IPs.
That means for all non HTTP applications please use the not so pretty port.
Currently only the following service will be reachable over the router:

- HTTP (:80)
- HTTPs (:443)
- Adminer (:8080)
- More services can be added here: `bin/imports/portMapping.sh` (A PR would be nice)

## 🧑‍💻 Setup

The following things need to be changed so that everything works.

### Prepare your projects

All services in your projects must be started with different ports. Otherwise, a second project cannot be started as individual ports are blocked.

`/home/projects/example/devenv.nix`

```nix
{ lib, config, ... }:

{
  # This will add a entry to /etc/hosts
  hosts = {
    "example.devenv" = "127.0.0.1";
  };

  # The env variables will hold the Port configuration.
  # In order not to annoy other developers, the standard
  # ports should be stored here. We overwrite the ports
  # in `devenv.local.nix` for your local enviroment.
  # Take a look in `bin/imports/portMapping.sh` for the names.
  env.DEVENV_ROUTER_DOMAIN = lib.mkDefault "example.devenv";
  env.DEVENV_ROUTER_PORT_ADMINER = lib.mkDefault 8080;

  services.adminer = {
    enable = lib.mkDefault true;
    listen = lib.mkDefault "127.0.0.1:${toString (config.env.DEVENV_ROUTER_PORT_ADMINER)}";
  };
}
```

`/home/projects/example/devenv.local.nix`

```nix
{ lib, ... }:

{
  # Set an individual port per project for each
  # service. The port must not be used in any other project.
  env.DEVENV_ROUTER_PORT_ADMINER = lib.mkForce 28080;

  # Change the Rest-API port for proccess-compose
  env.PC_HTTP_PORT = 64635;
}
```

### Configure devenv-router

```sh
# Clone the project to any location
git clone https://github.com/DevertNet/devenv-router.git /home/projects/devenv-router

# Jump into the folder
cd /home/projects/devenv-router

# Create the .env file
cp .env.example .env

# Edit the .env file (you can also use an IDE for this)
# In this case change SCAN_DIR to /home/projects/
nano .env

# Start the router
./start.sh
```

## 🤔 What happens on `./start.sh`?

1. All projects with a devenv.nix file are searched for in the SCAN_DIR folder (see .env).
2. In each of these folders `devenv info` is executed to search for the `DEVENV_ROUTER_*` variables. Projects with out `DEVENV_ROUTER_*` enviroment variables will ignored.
3. A caddy file is built from the information and stored in `dist/Caddyfile`.
4. The devenv caddy server with the reverse proxies is started.

## ✋ Contribution

Change requests or suggestions are welcome 😀.
In principle, you can also use another language instead of bash scripts to create the caddy file. A rewrite of the project should be done quickly.

Todo:

- (Automated) Tests
