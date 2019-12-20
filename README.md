# LogOps
Parent repository for LogOps, containing links to the repositories that contain the services which make up LogOps

# Setup requirements
Setting up the system requires a Kubernetes solution supporting LoadBalancers - e.g. Amazon EKS

To get the entire system, clone this repository along the submodules with:

 `git clone --recurse-submodules https://github.com/Strange96/LogOps`
 
# Setup
To get LogOps running, apply the Kubernetes files in the kubernetes directory in the following order:

// TODO

The following variables have to be set:

// TODO

# LogOps instructions
When the solution is up and running, LogOps can be used in the following way:

// TODO

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

