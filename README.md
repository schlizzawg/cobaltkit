# cobaltkit
idiot-proof composefile for running @wukko/cobalt

note that you cannot use this if you use the same server for serving HTTP content via a different, already installed server such as nginx

### setup
- install docker; *if you have it installed, make sure it's working. (the command `docker ps` should not result in an error)*
- copy `.env.example` to `.env` and edit `.env`:
    - if running both web and API (`COBALT_MODE=both`), set WEB_DOMAIN and API_DOMAIN
    - if running only API, set `COBALT_MODE` to `api` and set API_DOMAIN
    - make sure the particular domain/s' DNS A record is pointing to the server
- run `docker compose up -d`
- wait for caddy to acquire certificate/s
