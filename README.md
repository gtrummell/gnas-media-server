# GNAS Linuxserver HTPC App Templates

[Documentation](https://github.com/gtrummell/gnas-portainer-templates/wiki)

This repository hosts HTPC application template definitions for portainer.


## GNAS Portainer templates:

* [Cardigann](https://hub.docker.com/r/linuxserver/cardigann) Torznab/Torrentpotato Proxy by [LinuxServer.io](https://linuxserver.io)
* [CouchPotato](https://hub.docker.com/r/linuxserver/couchpotato) Movie Manager by [LinuxServer.io](https://linuxserver.io)
* [Headphones](https://hub.docker.com/r/linuxserver/headphones) Audio Manager by [LinuxServer.io](https://linuxserver.io)
* [Muximux](https://hub.docker.com/r/linuxserver/muximux) HTPC Management Interface by [LinuxServer.io](https://linuxserver.io)
* [NZBHydra](https://hub.docker.com/r/linuxserver/hydra) Newznab Proxy by [LinuxServer.io](https://linuxserver.io)
* [OpenVPN Access Server](https://hub.docker.com/r/linuxserver/openvpn-as) VPN Server by [LinuxServer.io](https://linuxserver.io)
* [SABnzbd](https://hub.docker.com/r/linuxserver/sabnzbd) Newznab Downloader by [LinuxServer.io](https://linuxserver.io)
* [Sonarr](https://hub.docker.com/r/linuxserver/sonarr) TV Series Manager by [LinuxServer.io](https://linuxserver.io)
* [Transmission](https://hub.docker.com/r/linuxserver/transmission) Torrent Downloader by [LinuxServer.io](https://linuxserver.io)

Documentation is available [ReadTheDocs](http://portainer.readthedocs.io/en/latest/templates.html) for more information about the template definition format and how to deploy your own templates for Portainer.

# Portainer compose setup

Simple setup to deploy these Portainer custom templates.

# Requirements

1. Install [Docker](http://docker.io).
2. Install [Docker-compose](http://docs.docker.com/compose/install/).
3. Clone this repository

# Usage

The default configuration will connect Portainer against the local Docker host.

Run it:

```
$ docker-compose up -d
```

And then access Portainer by hitting [http://localhost/portainer](http://localhost/portainer) with a web browser.

# Configuration

## How can I specify which Docker host I want to manage?

You'll need to pass the IP/hostname of your Docker host to the portainer binary.

Update the `command` field of the **portainer** service in the `docker-compose.yml` file:

```yml
portainer:
  image: portainer/portainer
  container_name: "portainer-app"
  command: --templates http://templates/templates.json -d /data -H tcp://<DOCKER_HOST>:<DOCKER_PORT>
  networks:
    - local
```

## How can I specify my own templates?

Create the file `templates/templates.json` and insert your template definitions in it.

For more information about the template definition format, see: https://github.com/portainer/templates

Then, bind mount the file for the **templates** service in the `docker-compose.yml` file:

```yml
templates:
  image: portainer/templates
  container_name: "portainer-templates"
  networks:
    - local
  volumes:
    - ./templates:/usr/share/nginx/html
```