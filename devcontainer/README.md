# All-in-one devcontainer

Here is a universal devcontainer image which I use for all my projects.
It contains all the sdk's, tools and utilities and can be used to instantly start working on any project.

It is quite large in size, but is shared across all projects, so actually it can save a lot of space in the long run.
Moreover, it is partially built using Nix, so updates are incremental and fast.

## Usage

Personally, I like to create all my devcontainers with docker-compose entrypoint, so I can easily extend them with additional services when needed.
Here is an example of how to use this devcontainer in your project:

.devcontainer/devcontainer.json

```json
{
  "name": "Project Name",
  "dockerComposeFile": "docker-compose.yml",
  "service": "main",
  "workspaceFolder": "/home/dev/workspace",
  "remoteUser": "dev"
}
```

.devcontainer/docker-compose.yml

```yaml
version: "3.9"

services:
  main:
    image: ghcr.io/exeteres/devcontainer:latest
    volumes:
      - ..:/home/dev/workspace:cached
    command: sleep infinity

networks:
  default:
    driver: bridge
    driver_opts:
      com.docker.network.driver.mtu: 1200
```

You can also add some credentials mounts like `~/.kube` or `~/.pulumi` to authenticate the tools.
You can also pass `/var/run/docker.sock` to the container to allow it to use the host's Docker daemon.

## Features

- Alpine Linux + common utilities
- Docker CLI (expecting Docker from host)
- Golang
- kubectl + helm + pulumi + crd2pulumi
- Node.js + corepack
- .NET SDK
- Protobuf + gRPC + plugins
- Python
