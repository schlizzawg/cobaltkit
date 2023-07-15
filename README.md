# cobaltkit
idiot-proof composefile for running [@wukko/cobalt](https://github.com/wukko/cobalt)

Note: you **cannot use this** on a server that already has a running webserver. You will need to set up cobalt yourself and set up your webserver to proxy it.

### prerequisites
- latest version of `docker` *(for podman, check the [podman branch](https://github.com/dumbmoron/cobaltkit/tree/podman))*
- git
- (sub)domain/s you want to use
  - *can be a normal domain, or something you got for free, such as a subdomain from freedns.afraid.org*

### setup
- clone this repo *(`git clone https://github.com/dumbmoron/cobaltkit.git`)*
- copy `.env.example` to `.env` and edit `.env` - contains additional guidance within
- **highly recommended:** if you are on Linux, you can run `./check.sh` to verify your configuration is correct
- run:
    - `docker compose up -d api` if you changed `COBALT_MODE` to `api`
    - `docker compose up -d` otherwise
