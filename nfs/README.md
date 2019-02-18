
## NFS Server for shared storage for PHP content

Install the Kubernetes manifests to setup an in-cluster NFS server for persistent shared storage.
The NFS server relies on a Digital Ocean persistent volume for it's storage.

``` bash
kubectl apply -f .
```
