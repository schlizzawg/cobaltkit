# cobaltkit
idiot-proof composefile for running [@wukko/cobalt](https://github.com/wukko/cobalt)

Note: you **cannot use this** on a server that already has a running webserver. You will need to set up cobalt yourself and set up your webserver to proxy it.

Warning: The podman version of cobaltkit does not have Watchtower, as it does not support podman, and therefore you will have to update the containers manually whenever an update is released (or make your own solution).

### prerequisites
- latest version of podman and podman-compose
- netavark (and aardvark-dns?)
- podman needs to be configured to use netavark (see [here](https://github.com/containers/podman-compose/issues/455#issuecomment-1189892693))
- git
- (sub)domain/s you want to use
  - *can be a normal domain, or something you got for free, such as a subdomain from freedns.afraid.org*

### setup
- clone this repo *(`git clone https://github.com/dumbmoron/cobaltkit.git`)*
- switch to the podman branch (`git checkout podman`)
- copy `.env.example` to `.env` and edit `.env` - contains additional guidance within
- **highly recommended:** if you are on Linux, you can run `./check.sh` to verify your configuration is correct
- run:
    - `podman-compose up -d api` if you changed `COBALT_MODE` to `api`
    - `podman-compose up -d` otherwise
