# LogOps
Parent repository for LogOps, containing links to the repositories that contain the services which make up LogOps

# Setup requirements
Setting up the system requires a Kubernetes solution supporting LoadBalancers - e.g. Amazon EKS

To get the entire system, clone this repository along the submodules with:

 `git clone --recurse-submodules https://github.com/Strange96/LogOps`

# Setup
To get LogOps running on aws, apply the Kubernetes files in the kubernetes/aws directory with these instructions:

1. Create an AWS ECR repository, and set PARSER_REPO in jolie-cloud.yml
2. Create an AWS EKS cluster with the name `LogOpsCluster` and add worker nodes to it
3. Create an `AWS access key id` and matching `AWS secret access key`, with access to the repository and cluster, and enter these in jolie-cloud.yml
4. Apply reverse-proxy-service.yml
5. Use `kubectl get svc reverse-proxy-service` to retrieve the url of the load balancer.
6. Update jolie-cloud.yml which uses this value in two deployments, and log-website needs it in one deployment.
7. Apply alarm.yml, jolie-cloud.yml, log-auth-db.yml, log-store-db.yml and log-website.
8. Wait at least 30 seconds
9. Apply reverse-proxy.yml log-store.yml and log-auth.yml
10. Wait 10 seconds
11. Use the url from step 2, and navigate your browser to it.

# LogOps instructions
When the solution is up and running, LogOps can be used in the following way:

Navigate to the login page in the upper-right corner.
You can log in as an admin with username: sandsized_admin and password: admin
Navigate admin control using the upper-right corner menu.
Here a new company may be added, under `Add company`.
Copy an id from the company list, and logout.
Navigate to the login page and create a new user using the id.
You can now login using the new account.

This part only works if running on AWS
Go to `Code management` and click create code. Enter a name, and some code, example: [Example Parser Code](https://github.com/Jakan16/Log-Jolie-Cloud/blob/master/builder/test/example_jolie_parser.ol)
Known issue: The builder service is only authorized to access the kubernetes service for 15 min at a time, and must be restated after this time span. This can be done with `kubectl delete pods -l app=builder`

Navigate to Subscription in the left menu.
Enter an agent name and click create.
Navigate a terminal to the Log-Agent/Files directory, and run the command

`python3 Agent.py [Company id used to create user] [agent license key] http://[url of load balancer]/auth http://[url of load balancer]/getParserHost [name of log parser]`

This will send the content of the files in the current working directory. Which can be found in `Log and Alarm management` found in the menu.

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
