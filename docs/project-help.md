# Requirements

* [Docker](http://docker.io).
* [Docker-compose](http://docs.docker.com/compose/install/).
* [This repository: GNAS Linuxserver.io Media Server Portainer
  Templates](https://github.com/gtrummell/gnas-portainer-templates).


# How do I get my media files into my GNAS?
Once you've launched a Portainer Stack, you can get your media into GNAS in one of
several ways:
* If your media files are already organized in a way that is compatible with the
  media managers you want to use, simply move your files into the appropriate
  directories.
* If your files are not organized, you may want to place them into Download
  directories respective of their type (i.e. `/storage/Downloads/audio`,
  `storage/Downloads/movies`, etc.), then use your desired media managers to import
  them.
* If you are simply rebuilding, and your directory structure already matches, then
  step 1 was a no-op for you.  You can simply launch your desired stack.

  
# Notes
* **SAMBA/NFS is still run on the host.**  We still run SAMBA4 on the host because it's
  dead simple, bulletproof, and we aren't on Active Directory networks.  You are welcome
  to add a SAMBA container if you prefer.  If you get a good one, let me know and I'll
  include it here.


# Troubleshooting
* **IT'S PROBABLY PERMISSIONS!** GNAS runs everything as `nobody:nogroup`, or
  `65534:65534`.  This works nicely due to the security properties of nobody/nogroup
  and it is compatible with SAMBA.  See notes for information about SAMBA.
