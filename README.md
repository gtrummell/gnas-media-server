# GNAS-Linuxserver.io Media Server Templates for Portainer

[![Build Status](https://travis-ci.org/gtrummell/gnas-media-server.svg?branch=master)](https://travis-ci.org/gtrummell/gnas-media-server)

This repository hosts Portainer Application Templates for
[Linuxserver.io](https://linuxserver.io) and several other HTPC Application Maintainers,
intended for educational and hobbyist activities.  See the [GNAS Linuxserver.io Media
Server Portainer Templates Wiki](https://github.com/gtrummell/gnas-media-server/wiki)
for more information.

## Quickstart
Launch Portainer and the GNAS app templates locally on your linux media server:

```bash
git clone https://github.com/gtrummell/gnas-media-server.git
cd gnas-media-server/stacks/gnas-bare-lsio-local
docker-compose up -d
```

For details on building and running Portainer Templates and Stacks from this
repository, see:
* [Usage - Templates](docs/usage-templates.md)
* [Usage - Stacks](docs/usage-stacks.md)
* [Help - Notes and Troubleshooting](docs/project-help.md)


## Portainer and Portainer Templates

[Portainer](https://portainer.io/) is an open-source, lightweight management UI which
allows you to easily manage your Docker hosts or Swarm clusters.

The Portainer App Template API and file format documentation are available at
[ReadTheDocs.io](http://portainer.readthedocs.io/en/latest/templates.html).  This
repository is patterned after Portainer default templates, available on [Portainer's
Templates repository on GitHub](https://github.com/portainer/templates).


## GNAS-Linuxserver.io Core Apps

GNAS is built using a variety of open-source projects.  All software in this
repository reserves their rights as enumerated in their licenses.  For more information,
see:

* [Docker](https://docker.io) container management engine
* [Portainer](https://portainer.io) Docker container engine manager
* [Prometheus](https://prometheus.io) monitoring software
* [LinuxServer.io Docker Images](https://linuxserver.io), maintainer of respective
  projects these deployed by these Portainer templates.
