# GNAS-Linuxserver.io HTPC Templates for Portainer

[![Build Status](https://travis-ci.org/gtrummell/gnas-portainer-templates.svg?branch=master)](https://travis-ci.org/gtrummell/gnas-portainer-templates)

This repository hosts Portainer Application Templates for Linuxserver.io
and several other HTPC Application Maintainers, intended for educational
and hobbyist activities.  See the [GNAS-Linuxserver.io HTPC Templates for
Portainer Wiki](https://github.com/gtrummell/gnas-portainer-templates/wiki)
for more information.


## Portainer and Portainer Templates

[Portainer](https://portainer.io/) is an open-source, lightweight management
UI which allows you to easily manage your Docker hosts or Swarm clusters.

The Portainer App Template API and file format documentation are available
at [ReadTheDocs.io](http://portainer.readthedocs.io/en/latest/templates.html).
This repository is patterned after Portainer default templates, available
on [Portainer's Templates repository on GitHub](https://github.com/portainer/templates).


## GNAS-Linuxserver.ioCore Apps

Although GNAS is built on Portainer the core apps containerized by [LinuxServer.io](https://linuxserver.io),
listed below.  Several other maintainer's containerized applications are
included in the main templates file provided by this repository:

* [Cardigann](https://hub.docker.com/r/linuxserver/cardigann) Torznab/Torrentpotato Proxy
  by [LinuxServer.io](https://linuxserver.io)
* [CouchPotato](https://hub.docker.com/r/linuxserver/couchpotato) Movie Manager
  by [LinuxServer.io](https://linuxserver.io)
* [Headphones](https://hub.docker.com/r/linuxserver/headphones) Audio Manager
  by [LinuxServer.io](https://linuxserver.io)
* [Muximux](https://hub.docker.com/r/linuxserver/muximux) HTPC Management Interface
  by [LinuxServer.io](https://linuxserver.io)
* [NZBHydra](https://hub.docker.com/r/linuxserver/hydra) Newznab Proxy
  by [LinuxServer.io](https://linuxserver.io)
* [OpenVPN Access Server](https://hub.docker.com/r/linuxserver/openvpn-as) VPN Server
  by [LinuxServer.io](https://linuxserver.io)
* [SABnzbd](https://hub.docker.com/r/linuxserver/sabnzbd) Newznab Downloader
  by [LinuxServer.io](https://linuxserver.io)
* [Sonarr](https://hub.docker.com/r/linuxserver/sonarr) TV Series Manager
  by [LinuxServer.io](https://linuxserver.io)
* [Transmission](https://hub.docker.com/r/linuxserver/transmission) Torrent Downloader
  by [LinuxServer.io](https://linuxserver.io)


## Requirements

* [Docker](http://docker.io).
* [Docker-compose](http://docs.docker.com/compose/install/).
* [This repository: GNAS Linuxserver.io HTPC Templates for Portainer](https://github.com/gtrummell/gnas-portainer-templates).


## Usage

There are several means of using the GNAS-Linuxserver.io HTPC Portainer
templates with Portainer.  They can be loaded via Portainer's UI, or at
the `docker run` command line via the `--templates` switch.

These configurations can be automated in Docker-compose files, or directly
into a NAS via init files (i.e. systemd, upstart, SysV Init)

### Dynamic Container-hosted templates

The default Docker-compose stack in `stacks/gnas-linuxserver-local` is configured
to build a `portainer-templates` container that serves the default templates
file live to Portainer itself the `portainer-app` container.  This stack
relies on Docker's built-in DNS to allow the app container to find the templates
container.  The templates file can be live-edited and reloaded on disk,
making this stack ideal for local development.

Run it:

```bash
cd stacks/gnas-linuxserver-local
docker-compose up -d
```


### Remote HTTPS or GitHub-hosted templates

If you prefer not to run your own web service to host template files, another
option is to retrieve the raw file from GitHub.  This example pulls the
GNAS-Linuxserver.io HTPC Portainer Templates as [raw JSON from GitHub](https://github.com/gtrummell/gnas-portainer-templates/blob/master/templates.json).

Run it:

```bash
cd stacks/gnas-linuxserver-remote
docker-compose up -d
```


### Using custom templates with dynamic Docker-compose stacks

The following steps illustrate how to create your own custom templates
and mount them in a webserver container.

1. Copy an existing template or create a new template and save it to a new
   file (i.e. `foo-stack-templates.json`) and insert your template definitions
   into it.  Make sure this file is accessible to your Docker host.
2. Copy an existing `docker-compose.yml` file, or create a new one.  Configure
   the Nginx `portainer-templates` container to mount the directory containing
   your new template file from the previous step.
3. Run `docker-compose up -d` in the directory containing your new Docker-compose
   file, then log into the Portainer host at http://localhost:9000 and begin using
   your templates!

This is an example `docker-compose.yml` section showing the `portainer-templates`
service mounting a live templates directory on the host system:

```yml
templates:
  container_name: portainer-templates
  image: nginx:stable-alpine
  ports:
    - 8080:80/tcp
  volumes:
    - /path/to/your-templates:/usr/share/nginx/html

app:
  command: [ "--templates", "http://portainer-templates/foo-stack-templates.json" ]
  container_name: portainer-app
  depends_on:
    - templates
  image: portainer/portainer:latest
  ports:
    - 9000:9000/tcp
  volumes:
    - /var/run/docker.sock:/var/run/docker.sock
    - /var/lib/portainer:/data

```

Then run it:

```bash
cd /parent/path-to/docker-compose-file/
docker-compose up -d
```


### Building a Docker image containing templates

If you are distributing your templates across multiple NAS servers, sharing
your templates, or simply backing up your templates for convenient retrieval
during a rebuild, you may want to copy your templates into a Docker image.
The included Docker image is an example of how to do so.  For more detailed
instructions, visit [Portainer Documentation on Building Your Own Templates](https://portainer.readthedocs.io/en/stable/templates.html#build-and-host-your-own-templates).