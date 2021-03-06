# LogOps
Parent repository for LogOps, containing links to the repositories that contain the services which make up LogOps

# Setup requirements
In order to run LogOps, you must have the following installed: 
* Docker
* docker-compose in a version compatible with version 3.7 files. E.g. version 1.25.0.
* python3
* mvn (maven)
* jolie - installed in the /usr directory, e.g. /usr/lib/jolie

To get the entire system, clone this repository along the submodules with:

 `git clone --recurse-submodules https://github.com/Strange96/LogOps`
 
# LogOps run instructions

Running the script: `runLogOps.sh`, will start all the services.

Once started and running in the terminal, press any key in that terminal to stop it.

When LogOps is running, you can access and use it through the website at `localhost:80`

For specfic usage of the individual services, please refer to the individual repositories

# Individual repositories
The respective respositories and their pipelines are accessible at:

Log-Agent: 
* Github: `https://github.com/Jakan16/Log-Agent` 
* Travis CI: `https://travis-ci.com/Jakan16/Log-Agent`

Log-Auth: 
* Github: `https://github.com/Jakan16/Log-Auth` 
* Travis CI: `https://travis-ci.com/Jakan16/Log-Auth`

Log-Jolie-Cloud: 
* Github: `https://github.com/Jakan16/Log-Jolie-Cloud` 
* Travis CI: `https://travis-ci.com/Jakan16/Log-Jolie-Cloud`

Log-Alarm-Service: 
* Github: `https://github.com/Strange96/log-alarm-service` 
* Travis CI: `https://travis-ci.com/Strange96/log-alarm-service`

Log-Store: 
* Github: `https://github.com/Jakan16/Log-Store` 
* Travis CI: `https://travis-ci.com/Jakan16/Log-Store`

Log-Website: 
* Github: `https://github.com/Jakan16/Log-Website` 
* Travis CI: `https://travis-ci.com/Jakan16/Log-Website`
