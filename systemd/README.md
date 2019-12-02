# Systemd init files

Files in this directory are init files for most systemd-based Linux distributions.
There are some situations in which you may want to use systemd instead of Portainer.
These might be scenarios where running a local binary is desired, such as the
Prometheus Node Exporter (required if you want to read local ZFS filesystem information
without tricky volume mounts or special capabilities to a container).  This is also
useful for situations where greater granularity or reliability is required on startup.
