MYSQL_PASSWORD=foo

echo "Installing a MySQL server."
kubectl apply -f mysql-pvc.yaml
helm install --name mtcdb -f values.yaml --set mysqlPassword=$MYSQL_PASSWORD stable/mysql
