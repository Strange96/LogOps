#!/bin/bash

# CREATE SHARED NETWORK
docker network create l_o_net

# BUILD PACKAGES FOR JOLIE CLOUD
JOLIE_PATH=$(locate jolie.jar | grep "^/usr.*/jolie.jar") && JOLIE_VERSION=$(jolie --version 2>&1 | sed 's/\(Jolie \)\([0-9]*\.[0-9]*\.[0-9]*\)\(.*\)/\2/g')
mvn install:install-file -Dfile=$JOLIE_PATH -DgroupId=jolie -DartifactId=jolie -Dversion=$JOLIE_VERSION -Dpackaging=jar
cd Log-Jolie-Cloud/ParserDeploy && mvn package && cd ../java/mongo4jolie && mvn package && cd ../../..

# INITIALIZE A COUPLE OF DBs
cd Log-Store && docker-compose up -d esdb && cd ..
cd log-alarm-service && docker-compose up -d mongo && cd ..

# START LOG-STORE, ALARM-SERVICE, JOLIE-CLOUD and SUBSCRIPTION-SERVICE
cd Log-Store && docker-compose up -d logstore && cd ..
cd log-alarm-service && docker-compose up -d alarmservice && cd ..
cd Log-Jolie-Cloud && docker-compose up -d && cd ..
#cd Log-Agent && bash -c 'python3 Server.py &' > /dev/null && cd Files && bash -c 'python3 Agent.py company42 license42 & > /dev/null' > /dev/null && cd ../..
cd Log-Auth && docker-compose up -d && cd ..

# CONNECT SERVICES TO SHARED NETWORK
docker network connect l_o_net logstore
docker network connect l_o_net alarmservice
docker network connect l_o_net parsermanager
docker network connect l_o_net builder
docker network connect l_o_net subscription

# EXPORT IPS OF SERVICES
#export NGINX_GLOBAL_URL=http://localhost:80
export NGINX_LOGSTORE_URL=http://localhost:8079
export NGINX_ALARMSERVICE_URL=http://localhost:8085
export NGINX_JOLIECLOUD_URL=http://localhost:8001
export NGINX_AUTHSERVICE_URL=http://localhost:7900
export NGINX_GETPARSERHOST_URL=http://localhost:8006

#export GLOBAL_URL=http://localhost
#export LOGSTORE_URL=http://localhost:8079
#export ALARMSERVICE_URL=http://localhost:8085
#export JOLIECLOUD_URL=http://localhost:8001
#export AUTHSERVICE_URL=http://localhost:7900
#export php_ADDR=php
#export MYSQL_ADDR=mysql

#LOGSTORE_URL=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' logstore)
#ALARMSERVICE_URL=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' alarmservice)
#JOLIECLOUD_URL=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' parsermanager)
#AUTHSERVICE_URL=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' authservice)

# START WEBSITE
cd Log-Website && docker-compose up -d && docker network connect l_o_net php && docker network connect l_o_net nginx && cd ..

echo $'\nPress any key to stop LogOps - but why would you? ;-)'
read -n 1 -s

cd Log-Website && docker-compose down && cd ..
cd Log-Auth && docker-compose down && cd ..
#kill -9 $(ps aux | grep Server.py | awk {'print $2'} | head -1)
#kill -9 $(ps aux | grep Agent.py | awk {'print $2'} | head -1)
cd Log-Jolie-Cloud && docker-compose down && cd ..
cd log-alarm-service && docker-compose down && cd ..
cd Log-Store && docker-compose down && cd ..

#unset AUTHSERVICE_URL
#unset JOLIECLOUD_URL
#unset ALARMSERVICE_URL
#unset LOGSTORE_URL
#unset MYSQL_ADDR
#unset php_ADDR
#unset GLOBAL_URL

#unset NGINX_GLOBAL_URL
unset NGINX_LOGSTORE_URL
unset NGINX_ALARMSERVICE_URL
unset NGINX_JOLIECLOUD_URL
unset NGINX_AUTHSERVICE_URL
unset NGINX_GETPARSERHOST_URL

docker network rm l_o_net
