#!/bin/sh
docker container stop mysql1 ndb2 ndb1 management1 && docker container rm mysql1 ndb2 ndb1 management1
docker container stop ndb_mgm && docker container rm ndb_mgm
docker container stop api-php-apache && docker container rm api-php-apache
docker network rm cluster