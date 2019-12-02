# Usage - Portainer Stacks/Docker-Compose Files
   
In addition to Portainer templates that allow you to launch individual containers as
desired, this repository also contains Portainer Stacks.  Portainer Stacks are Docker-
Compose v2.0 files containing a group of applications intended to run together.  The
Portainer Stacks included in this repository can be launched directly from GitHub via
raw source URLs after some setup.  Portainer Stacks included in this repository are
listed below.  See individual READMEs for details.

* **[GNAS EMR Linuxserver.io Stack](..stacks/gnas-emr-lsio-remote/README.md):** Launches
  modern "EMR" (Radarr/Sonarr/Lidarr) Media Server stack using
  [this Docker-Compose file](..stacks/gnas-emr-lsio-remote/docker-compose.yml).
* **[GNAS Classic Linuxserver.io Stack](..stacks/gnas-classic-lsio-remote/README.md):**
  Launches a classic CouchPotato/SickGear Media Server stack using
  [this Docker-Compose file](..stacks/gnas-classic-lsio-remote/docker-compose.yml).
* **[GNAS Prometheus Monitoring Stack](..stacks/gnas-monitoring-remote/README.md):**
  Launches a complete Prometheus/Grafana monitoring stack using
  [this Docker-Compose file](..stacks/gnas-monitoring-remote/docker-compose.yml).
* **[GNAS 415 Linuxserver.io Stack](..stacks/gnas-415-lsio-remote/README.md):** Launches
  a fully-loaded modern Media Server stack with Kodi-Headless and Prometheus Monitoring
  using [this Docker-Compose file](..stacks/gnas-415-lsio-remote/docker-compose.yml).
* **[GNAS Bare Linxuserver.io Stack](..stacks/gnas-bare-lsio-local/README.md):** Launches
  a bare Portainer stack with local Linuxserver.io Templates using
  [this Docker-Compose file](..stacks/gnas-bare-lsio-local/docker-compose.yml).
* **[GNAS Bare Linuxserver.io Stack](..stacks/gnas-bare-lsio-remote/README.md):**
  Launches a bare Portainer stack with remote Linuxserver.io Templates using
  [this Docker-Compose file](..stacks/gnas-bare-lsio-remote/docker-compose.yml).


## Preparing to launch a GNAS Portainer Stack

Launching one of the Portainer Stacks directly from this repository requires a few
setup steps:

**1. Create directories on your NAS for configuration files and storage.**  Issue the
following commands:

  _We are only creating top-level directories for configuration and media.  Docker will
  create subdirectories as needed._
```bash
mkdir -p /opt/gnas \
  /storage/Audio \
  /storage/Documents \
  /storage/Downloads \
  /storage/DVR \
  /storage/Games \
  /storage/Movies \
  /storage/Music \
  /storage/Pictures \ 
  /storage/Transcode \
  /storage/TV \
  /storage/Vides
```

  _We set permissions to nobody:nogroup in order to set a uniform and safe user for all
  media applications.  It may be necessary to run this command again after first run of
  the Portainer stack._
```bash
chown -R nobody:nogroup /opt/gnas /storage
```

**2. Launch Portainer.**  Use Docker-Compose to experiment and Systemd to start
Portainer on system startup.

To launch Portainer with Docker-Compose, see _Usage - Templates_ above.

To launch Portainer on system start, copy its systemd unit file to your server and
start the service.
```bash
cp systemd/portainer.service /etc/systemd/system/
chmod 0644 /etc/systemd/system/portainer.service
systemctl daemon-reload
systemctl enable portainer.service
systemctl start portainer.service.
```

**3. Launch a Portainer Stack.**  Choose a stack from this repository (other than a
bare stack - they contain no apps), or create your own stack.  Then launch it using
Portainer's Stacks UI.  We'll use GNAS EMR as an example.

* Open your portainer UI, for example: http://gnas:9000
* Browse to _Stacks_ in the left menu, then click _+ Add Stack_.
* Choose one of the three available methods to upload your stack to Portainer (_Web
  Editor_, _Upload from your computer_, or _Git Repository_)

Using Web Editor and Upload from your computer are straightforward.  Copy and paste
or choose a Portainer Stack on disk.

Using Git Repository with GNAS EMR would be configured as follows:
* _Repository URL:_ `https://github.com/gtrummell/gnas-portainer-templates`
* _Repository Reference:_ `/refs/heads/master`
* _Compose Path:_ `stacks/gnas-emr-lsio-remote/docker-compose.yml`
