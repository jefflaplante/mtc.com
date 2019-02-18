# Mturk Crowd Kubernetes Setup

### App Docker Container:
https://github.com/jefflaplante/docker_mtc_app

### Helm Chart for MTC App
https://github.com/jefflaplante/mtc

### Application flow

* cdn.mturkcrowd.com -> mtc-2d56.kxcdn.com (Key CDN) -> origin.mturkcrowd.com (CDN Origin)
* www.mturkcrowd.com -> origin.mturkcrowd.com -> 138.197.235.68 (Floating IP)
* 138.197.235.68 is assigned to Origin droplet (HAProxy)

#### HAProxy Routing

Backends:

* App Digital Ocean Load Balancer - 157.230.72.215:80
  * Default backend for MTurkCrowd Webapp
* Spaces Bucket - mtc.nyc3.digitaloceanspaces.com:443
  * Object storage for static assets
    * /emoticons/
    * /styles/
    * googlec298216b9bf502b3.html
    * BingSiteuth.xml
    * crossdomain.xml
    * favicon.ico
    * health.json
    * robots.txt
* Let's Encrypt - 127.0.0.1:54321
  * Allows for renewing TLS certificates with Let's Encrypt.
* HAProxy Stats - *:22002
  * Statistics on HAProxy

### Installation

* Setup Workstation.
  * Install kubectl.
  * Install Helm.
* Create origin DO Droplet.
  * Install HAProxy, NGINX, and certbot.
  * Copy configuration files to droplet.
* Setup Kubernetes Cluster in Digital Ocean.
  * Download kubeconfig.
* Install Tiller in k8s cluster.
* Install NFS Server in k8s cluster.
  * `cd nfs`
  * `kubectl apply -f *`
  * Note NFS server service IP address for use in app pvc.
  * Fix up nfs client pvc manifest to referene NFS server service IP address.
* Install mysql Helm chart.
  * `cd mysql`
  * `kubectl apply -f mysql-pvc.yaml`
  * `helm install --name mtcdb -f values.yaml --set mysqlPassword=$MYSQL_PASSWORD stable/mysql`
  * Copy MySQL database files to data persistent volume.
* Install MTC app Helm chart.
  * Download prod.yaml from vault or 1Password.
  * Fix up pvc manifest to referene NFS server service IP address.
  * `git clone https://github.com/jefflaplante/mtc.git`
  * `cd mtc`
  * `helm install --name mtc -f prod.yaml .`
  * Copy data to NFS share.
* Install App Load Balancer
  * `kubectl apply -f loadbalancer.yaml`
* Update origin HAProxy config to point at Digital Ocean load balancer IP.
