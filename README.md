# Devops Test
### Overview
This is an application that is a dummy webservice that returns the
last update time.  The last updated time is cached in redis and
resets every 5 seconds.  It has a single '/' endpoint.  The redis
address is passed in through the environment.
NOTE: The following tasks should take no more than 1 hour total.
### Tasks
1. create Dockerfile for this application
2. create docker-compose.yaml to replicate a full running environment
so that a developer can run the entire application locally without having
to run any dependencies (i.e. redis) in a separate process.
3. explain how you would monitor this application in production. please
write code/scripts to do the monitoring.
### MiniKube Tasks
4. prepare local Kubernetes environment (using MiniKube + Helm) to run our application in pod/container.
it should be created a helm chart with resources for deploying application to Kuberenetes. 
store all relevant scripts (kubectl commands etc) in your forked repository.
5. suggest & create minimal local infrastructure to perform functional testing/monitoring of our application pod.
demonstrate monitoring of relevant results & metrics for normal app behavior and failure(s).

Please fork this repository and make a pull request with your changes.
Please provide test monitoring results in any convenient form (files, images, additional notes) as a separate archive.



 
### Additional task
Research https://agones.dev/site/. Deploy agones locally (minikube or docker desktop, kubernetes) or in any cloud. AWS is a big plus. Use https://github.com/googleforgames/agones/tree/main/examples/xonotic as dedicated server. Xonotic client should be able to join a dedicated server. Matchmaker or any other automatic fleet management is not required. Fleet could be managed manually with agones rest api. Provide documentation with steps how to reproduce the environment and test the game


##Commands for Docker Compose Stack

###Stop & Start
Start stack golang app + redis:
`docker-compose up -d`

Stop stack golang app + redis:
`docker-compose down`

> For production usage need to use external services and special monitoring system (like prometheus) and log system (like ELK) and alert by tech requiremnets (like alertmanager) or any solution witch currently used in existing environments.

But for local testing I can recommend following commands:

###Redis Monitoring

Check Redis works for 1 time test. Response: PONG

`docker exec -ti redis redis-cli ping`

Check redis works fine with his data

`docker exec -ti redis redis-cli monitor`



###App Monitoring

Get 200 Code
`curl -s -o /dev/null -w "%{http_code}" http://localhost:8080 `

To get logs for goapp
`docker logs devops_test -f`

##HELM

Build image from Dockerfile

`minikube image build -t devops_test .`

Move to devops-test-minikube folder

`cd devops-test-minikube`

Add bitnami repo 

`helm repo add bitnami https://charts.bitnami.com/bitnami`

Update REDIS bitnami dependency
`helm dependency update`

Need to run helm install with new namespaces (devops1 as example)

`helm install devops-test-minikube ./ -n devops1 --create-namespace --wait`

You will see some commands for **port-forwarding**. Run it.

###Testing

Need to use `port-forward` before testing.

Command to GET 2 times per second 
`watch -n 0.5 'curl -s /dev/null localhost:8080'`

`chmod +x smalltests.sh`
Run tests
`./smalltests.sh`

You can change URI parameters for testing in variable
`requests="/ /88 /admin /"`

##Additional info

To **Expose** service to separate IP:PORT

`kubectl expose deployment devops-test-minikube --type=LoadBalancer --name=devops-test-web -n devops1`

Open exposed url in your browser:

`minikube service devops-test-web`

Get exposed url link:

`minikube service devops-test-web --url`

Uninstall

`helm uninstall devops-test-minikube -n devops1`
