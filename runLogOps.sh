#!/bin/bash

# START BY INITIALIZING DBs
cd Log-Store && docker-compose up -d esdb && cd ..
cd log-alarm-service && docker-compose up -d mongo && cd ..

# START LOG-STORE, ALARM-SERVICE, JOLIE-EXECUTOR, AGENT-SERVICE AND SUBSCRIPTION-SERVICE
cd Log-Store && docker-compose up -d logstore && cd ..
cd log-alarm-service && docker-compose up -d alarmservice && cd ..
cd Log-Jolie-Cloud && docker-compose up -d && cd ..
cd Log-Agent && python Server.py & && cd Files && python Agent.py & && cd ../..
cd Log-Auth && docker-compose up -d && cd ..

# START WEBSITE
cd Log-Website && docker-compose up -d && cd ..

echo $'\nPress any to stop LogOps - but why would you? ;-)'
read -n 1 -s

cd Log-Website && docker-compose down && cd ..
cd Log-Auth && docker-compose down && cd ..
kill -9 $(ps aux | grep Server.py | awk {'print $2'} | head -1)
kill -9 $(ps aux | grep Agent.py | awk {'print $2'} | head -1)
cd Log-Jolie-Cloud && docker-compose down && cd ..
cd log-alarm-service && docker-compose down && cd ..
cd Log-Store && docker-compose down && cd ..
