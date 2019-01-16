#!/bin/sh
mysqlip=192.168.0
if [ -f "mysql-docker/cnf/my.cnf" ]; then
	rm mysql-docker/cnf/my.cnf
fi
if [ -f "mysql-docker/cnf/mysql-cluster.cnf" ]; then
	rm mysql-docker/cnf/mysql-cluster.cnf
fi
cat mysql-docker/cnf/my.cnf-bak | sed "s/$mysqlip/$1/g" >> mysql-docker/cnf/my.cnf
cat mysql-docker/cnf/mysql-cluster.cnf-bak | sed "s/$mysqlip/$1/g" >> mysql-docker/cnf/mysql-cluster.cnf

docker build -t mysql-cluster mysql-docker
# docker network create cluster --subnet="$1.0/16"
# docker run -d --net=cluster --name=management1 --ip=10.100.0.2 mysql-cluster ndb_mgmd
docker network create cluster --subnet="$1.0/16"
docker run -d --net=cluster --name=management1 --ip="$1.2" -p 3309:3306 mysql-cluster ndb_mgmd
docker run -d --net=cluster --name=ndb1 --ip="$1.3" -p 3307:3306 mysql-cluster ndbd
docker run -d --net=cluster --name=ndb2 --ip="$1.4" -p 3308:3306 mysql-cluster ndbd
docker run -d --net=cluster --name=mysql1 --ip="$1.10" -p 3306:3306 -e MYSQL_RANDOM_ROOT_PASSWORD=true mysql-cluster mysqld
echo "build finish\n\n"
docker run -dit --net=cluster --name=ndb_mgm mysql-cluster ndb_mgm