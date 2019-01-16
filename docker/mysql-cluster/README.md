## MySQL Cluster setup in docker

1. run `./build.sh {network ip}`
wait a moment
5. `docker logs mysql1 2>&1 | grep PASSWORD`
6. `docker exec -it mysql1 mysql -uroot -p`
  1. `ALTER USER 'root'@'localhost' IDENTIFIED BY 'root';`
  2. `GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'root';`
7. `docker container restart mysql1`
8. Run cluster manager `docker run -it --net=cluster mysql/mysql-cluster ndb_mgm --name=ndb_mgm`