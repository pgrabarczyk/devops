# 004-aws-terraform-modules

![draw_004](https://github.com/pgrabarczyk/devops/raw/master/004-aws-terraform-modules/img/draw.png)

Idea is to build development env where instances from test and development env can ran.

First terraform script (dev-init) build dev env (VPC, subnets, IGW, NAT-GW, security groups, keypair and one EC2 jenkins-slave).
Second terraform script (test-resources) search for existing dev env (created before) and ran jump-service and Backend services as test env.

In future this scripts can be used to build dev-resources.
For prod env those scripts could be also used - I suggest to build independent VPC for prod env).


## Before execute
1. You need 3 AMIs:
- jenkins slave with tag:Name = "${app-name}-jenkins-slave" and tag:Service = "jenkins-slave"
- jump-service with tag:Name = "${app-name}-jump-service" and tag:Service = "jump-service"
- be-service with tag:Name = "${app-name}-be-service" and tag:Service = "be-service"
The newest will be used.\
2. You need to create one VPC EIP which will be used for jenkins slave.
3. Jenkins Master which will have configured slave using ip from (2).

## Execute

```
cd dev-init
terraform plan -var-file=dev.tfvars
terraform apply -var-file=dev.tfvars
```

```
cd ../test-resources
terraform plan -var-file=test.tfvars
terraform apply -var-file=test.tfvars
```

Remember to terraform destroy both scripts and the end.

## Runned on configuration:
```
Terraform v0.10.2
```
