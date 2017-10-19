# 008-aws-cloudwatch-kibana

### Execute (step by step):

###### Terraform creates EC2 IAM ROLE, EC2, CloudWatch LogGroup, CloudWatch LogStream
```
cd terraform
terraform init
terraform plan -var-file=008.tfvars -out=plan.out
terraform apply plan.out
```

Terraform will create IAM Role for EC2 with policy:
```
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents",
        "logs:DescribeLogStreams"
      ],
      "Resource": "arn:aws:logs:*:*:*"
    }
  ]
}
```

That's why to execute this terraform your user need to have role:
```
iam:CreateRole
```

###### Ansible install java
//TODO
###### Ansible install agent for sending logs to cloudwatch
//TODO
###### Ansible execute send and execute java application generating logs.

//TODO execute ansible playbook

Source of java application can be found [here](https://github.com/pgrabarczyk/spring-cloud/tree/master/spring-cloud-sleuth-scheduler)

Logs should be at:
```
/home/ubuntu/logs/spring-cloud-sleuth-scheduler.log
```

###### Check cloud watch
//TODO
###### TODO Kibana
//TODO
