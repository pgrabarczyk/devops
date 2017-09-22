# 002-aws-terraform-ansible
Create aws env with terraform then execute ansible scripts to create 3 backend services with java running application.
Load balancer will balance traffic between those 3 backend services.

![draw_002](https://github.com/pgrabarczyk/devops/raw/master/002-aws-terraform-ansible/img/draw.PNG)

## Execute:
```
cd terraform
terraform plan -var-file=002.tfvars
terraform apply -var-file=002.tfvars
```

Then aws env should be mostly ready.

Now you should be able to execute ansible script:
```
cd ../ansible
ansible-playbook -i all.host playbook.yml -vvv
```

You can ssh to your backend_services using:
```
ssh -i PATH_TO_KEY -o ProxyCommand="ssh -W %h:%p -q ubuntu@JUMP_SERVICE_PUBLIC_IP" ubuntu@BACKEND_SERVICE_PRIVATE_IP
```

You can enter AWS console and check Load Balancer.
There your services should be visible as "InService"
![draw_002](https://github.com/pgrabarczyk/devops/raw/master/002-aws-terraform-ansible/img/InServices.PNG)
Go and copy DNS of ELB, then execute it with "/host" suffix, eg:
```
http://pgrabarczyk-elb-120425907.eu-west-1.elb.amazonaws.com/host
```
After reloads you can see local ip addresses of backend services, eg:
```
fe80:0:0:0:488:c5ff:fed6:53e8%eth0
10.0.11.32
0:0:0:0:0:0:0:1%lo
127.0.0.1
```
ip of eth0 (eg. 10.0.11.32) should be changing after each reload

### Clean up (Destroy AWS environment)
```
cd ../terraform
terraform destroy -var-file=002.tfvars
```

## Runned on configuration:
```
Terraform v0.10.2
ansible 2.4.0.0
python version = 2.7.12 (default, Nov 19 2016, 06:48:10) [GCC 5.4.0 20160609]
```
