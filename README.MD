#A18
## How to deploy
- we need to run the pipeline  ./deploy-lambda/pipeline.yaml
- run terraform apply within ./terraform

### Pipeline
 pipeline makes sure to:
  1. deploy the lambda function to aws
  2. deploy the api-gateway to docker-hub
  
## Terraform

 terraform will create:
  1. Frontend: HA load balancer
  2. Backend: HA auto-scale group.
  
Launch configuration:
- each instance will bootstrap two containers:
    1. httpd
    2. lambda endpoint
    
# POC compromises
- don't implement the pipeline that builds and push the images - do it manually.
- don't implement the terraform that describe the infra - do it click-by-click on the aws console

# security measures to protect this API
- design the  vpc with public and private subnets
- public subnet are used to frontend load-balancer
- private subnets are used to backend auto-scale group
- we need to take care for internet access of the backend workers (for installing things) - we will add NAT-GW in the public subnet and make sure for the correct rules in the routing tables

# Authenticating against the API
 we can use TLS with a certificate
 we can define our load-balancer as the tls terminator or our backends server
 
