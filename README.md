# ShockLink WebUI

This is the ShockLink Web UI. It is a single-page application that communicates with the [ShockLink API](https://github.com/Shock-Link/API). It is written using JavaScript and SCSS using the Vue 3 framework.

## Contents

- [Configuring](#configuring)
- [Deployment](#deployment)
  - [Using Docker](#using-docker)
  - [Using `docker-compose`](#using-docker-compose)
- [Development](#development)
  - [Dependencies](#dependencies)
  - [Development](#development-1)
  - [Build](#build)
  - [Support](#support)

# Configuring

The [shocklink-webui](https://github.com/Shock-Link/WebUI/pkgs/container/shocklink-webui) container supports configuration via environment variables.

**NOTE:** All of the below values are always prefixed with `https://`. This cannot be omitted.

|Variable|Default|Description|
|-|-|-|
|`SHOCKLINK_API_URL`|`api.shocklink.net/`| URL of the API. |
|`SHOCKLINK_WEBUI_URL`|`shocklink.net/#/`| URL of the ShockLink WebUI. |
|`SHOCKLINK_SHARE_URL`|`shockl.ink/s/`| URL to prefix share links with. When visited, should redirect to `${SHOCKLINK_WEBUI_URL}/public/proxy/shares/links/{ID}`. |

# Deployment

This documentation describes how to self-host the WebUI container. This might not be of interest to you if you are content using [ShockLink.net](https://shocklink.net).

## Using Docker
Assuming you are running on `localhost`, with [the API](https://github.com/Shock-Link/API) running on port `5001`:

```bash
$ docker run \
    -p 5002:80/tcp \
    -e SHOCKLINK_API_URL=localhost:5001/ \
    -e SHOCKLINK_WEBUI_URL=localhost:5002/#/ \
    -e SHOCKLINK_SHARE_URL=localhost:5002/#/public/proxy/shares/links/ \
    --name shocklink-webui \
    ghcr.io/shocklink/webui:latest
```

## Using `docker-compose`

Assuming a deployment on `localhost`:

```yml
version: '3.9'

services:

  # Database. Only Postgres is currently supported.
  db:
    image: postgres:16
    environment:
      - POSTGRES_PASSWORD=postgres
  
  # Redis with Redisearch.
  redis:
    image: redislabs/redisearch:latest

  # The API.
  # Check https://github.com/Shock-Link/API for the latest configuration settings.
  api:
    image: ghcr.io/shock-link/api:latest
    depends_on:
      - db
      - redis
    ports:
      - "5001:80/tcp"
    environment:
      - FRONTEND_BASE_URL=localhost
      - REDIS_HOST=redis
      - DB=db
  
  # The Web UI (this repository).
  webui:
    image: ghcr.io/shock-link/webui:latest
    depends_on:
      - api
    ports:
      - "5002:80/tcp"
    environment:
      - SHOCKLINK_API_URL=localhost:5001/
      - SHOCKLINK_WEBUI_URL=localhost:5002/#/
      - SHOCKLINK_SHARE_URL=localhost:5002/#/public/proxy/shares/links/
```

# Development
Contributions are welcome! We're eager to see what you come up with. Make sure to [join us on Discord](https://discord.gg/AHcCbXbEcF).

## Dependencies

To get started with development, you will need the following things:
- NodeJs 17.9.1 or newer.
- An IDE or editor:
  - VSCode
  - Web- or PhpStorm

## Development
To start a local development server, check out the repository and run the command `npm run start`.

## Build
To make a production ready build, use the command `npm run build`.
This will output static web files to `./dist/` which can be deployed on pretty much any webserver.

This also works for cloudflare pages auto build pipeline.

## Support
You can support me and my projects here [Ko-fi.com/LucHeart](https://ko-fi.com/lucheart)