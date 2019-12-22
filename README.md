# LogOps
Parent repository for LogOps, containing links to the repositories that contain the services which make up LogOps

# Setup requirements
Setting up the system requires a Kubernetes solution either supporting LoadBalancers (e.g. Amazon EKS), or a local Kubernetes setup (e.g. Kind (Kubernetes in Docker) https://github.com/kubernetes-sigs/kind)

To get the code of the entire system, clone this repository along the submodules with:

 `git clone --recurse-submodules https://github.com/Strange96/LogOps`

# Setup
To get LogOps running on AWS, apply the Kubernetes files in the kubernetes/aws directory with these instructions:

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

To run LogOps on a local cluster, do the following with the files in the kubernetes/local directory:

1. run `kubectl apply -f deploy1.yml` and wait 30 seconds 
2. run `kubectl apply -f deploy2.yml` and wait 30 seconds
3. run `kubectl apply -f deploy_auth.yml`
4. run `kubectl apply -f services.yml`

Locally, the website will be available at `localhost:30077`. 

If using Kind (Kubernetes in Docker), create the cluster with the config `port_forwarder.yml` in kubernetes/local/kind_config directory. E.g. from the kubernetes/local directory, run: 
* `kind create cluster --config kind_config/port_forwarder.yml` 

To interact directly with the individual services, send requests to:
* `ROOT` for the website
* `ROOT/gateway` for the log-store
* `ROOT/alarms` for the alarm-service
* `ROOT/auth` for the authentication/subscription-service
* `ROOT/getParserHost` for the builder
* `ROOT/submitCode`, `ROOT/retrieveCode`, `ROOT/deleteCode` for the parser

Where ROOT refers to your AWS URL or, for a local cluster, localhost

# LogOps instructions
When the solution is up and running, LogOps can be used in the following way:

Navigate to the login page in the upper-right corner. You can log in as an admin with the following credentials: 
* username: sandsized_admin 
* password: admin

Navigate to admin control using the menu in the upper-right corner. Here a new company may be added under 'Add company'. Below under 'companies', save the company license of the company you created (to the right of the company name), and logout via the menu in the upper-right corner. Navigate to the login page again and create a new user using the company license. You can now login using the new account and open your dashboard via the menu in the upper-right corner.

If running on AWS, go to 'Code management' and click create code. Enter a name and some code, example: [Example Parser Code](https://github.com/Jakan16/Log-Jolie-Cloud/blob/master/builder/test/example_jolie_parser.ol). 
Known issue: The builder service is only authorized to access the kubernetes service for 15 min at a time, and must be restated after this time span. This can be done with `kubectl delete pods -l app=builder`. The deployment will automatically start the new pods.

If you're running LogOps locally, instead of the above which only applies to AWS, go to the 'Code management' menu on the left, click create code and provide a name. Locally, no code needs to supplied - this is explanied later on.

Navigate to Subscription in the left menu. Enter an agent name, click create and save the agent license key. Open a terminal and go to the Log-Agent/Files directory. Run the following command:

`python3 Agent.py [Company id used to create user] [agent license key] http://[url of load balancer]/auth http://[url of load balancer]/getParserHost [name of log parser]`

`Name of log parser` is a name that you used for creating code. The command will start the Agent which will send the content of the files in the current working directory (that is Log-Agent/Files) to the log parser.

E.g. if running locally and the company id/license is 'abcd-1234', the agent license is 'xyz-42' and you named your code 'mycode', run:

`python3 Agent.py abcd-1234 xyz-42 http://localhost:30077/auth http://localhost:30077/getParserHost mycode`

LogOps starts a new machine for a new parser/new code. As this is not possible locally, the local solution overwrites your code with a default log parser. This reads the content of the files in Log-Agent/Files directory and saves it as logs. If a file contains the text `alert:alert-name:severity-name` (replacing alert-name and severity-name with your own choice), the default log parser will raise the alarm through the alarm-service. 

The logs that are created and the alarms which are raised by parsing the logs, which are sent by the Agent, can be found on the website under the `Log management and Alarm management` menus. 
* Click on the magnifying glass at right of an alarm to see which logs raised that alarm.
* Click on 'open log' at the right of a log to get the content of the log displayed.

For more specfic usage of the individual services, please refer to the individual repositories

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
