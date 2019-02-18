### Origin

The Origin server is a small droplet to run HAProxy as a router and NGINX for a backup web server.

#### Files

* cert_renew - script to renew TLS certificates
* crontab - Crontab entry to automate calling cert_renew.
* haproxy.cfg - HProxy configuration file.
* iptables.sav - Iptables firewall ruleset.
* nginx.conf - NGINX main configuration file.
* oops.conf - NGINX oops site configuration file.
* oops.html - Oops html page.

#### Setup

Install nginx.
Install haproxy.
Install letsencrypt.
Install iptables.
Install iptables-persistent.

``` bash
apt-get update
apt-get install nginx haproxy iptables iptables-persistent -y
apt-get install software-properties-common
add-apt-repository universe
add-apt-repository ppa:certbot/certbot
apt-get update
apt-get install certbot
```
