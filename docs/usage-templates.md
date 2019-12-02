# Usage - Templates

There are several means of using the GNAS-Linuxserver.io HTPC Portainer
templates with Portainer.  They can be loaded via Portainer's UI, or at
the `docker run` command line via the `--templates` switch.

These configurations can be automated in Docker-compose files, or directly
into a NAS via init files (i.e. systemd, upstart, SysV Init)


## Dynamic Container-hosted templates

The default Docker-compose stack in `stacks/gnas-bare-lsio-local` is configured
to build a `portainer-templates` container that serves the default templates
file live to Portainer itself the `portainer-app` container.  This stack
relies on Docker's built-in DNS to allow the app container to find the templates
container.  The templates file can be live-edited and reloaded on disk,
making this stack ideal for local development.

Run it:

```bash
cd stacks/gnas-bare-lsio-local
docker-compose up -d
```


## Remote HTTPS or GitHub-hosted templates

If you prefer not to run your own web service to host template files, another
option is to retrieve the raw file from GitHub.  This example pulls the
GNAS-Linuxserver.io HTPC Portainer Templates as
[raw JSON from GitHub](https://github.com/gtrummell/gnas-portainer-templates/blob/master/templates.json).

Run it:

```bash
cd stacks/gnas-bare-lsio-remote
docker-compose up -d
```


## Using custom templates with dynamic Docker-compose stacks

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


## Building a Docker image containing templates

If you are distributing your templates across multiple NAS servers, sharing
your templates, or simply backing up your templates for convenient retrieval
during a rebuild, you may want to copy your templates into a Docker image.
The included Dockerfile is an example of how to do so.  For more detailed
instructions, visit
[Portainer Documentation on Building Your Own Templates](https://portainer.readthedocs.io/en/stable/templates.html#build-and-host-your-own-templates).
