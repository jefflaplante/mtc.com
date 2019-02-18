
## Install Mysql database helm chart with values file for mturkcrowd.

### Create PVC for mysql data
```
kubectl apply -f mysql-pvc.yaml
```

### Install helm chart for mysql
```
helm install --name mtcdb -f values.yaml --set mysqlPassword=foo stable/mysql
```

Be sure to override the password field.

