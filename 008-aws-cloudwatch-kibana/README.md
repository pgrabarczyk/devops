# 008-aws-cloudwatch-kibana

### Project in progress / TODO:

- Add elasticsearch in terraform
- results of elasticsearch (screenshoot?) in readme
- refactor ansible playbook
- refactor to keep ansible and terraform settings (eg. region in 1 file)

### Execute (fast):

```
cd terraform
terraform init
terraform plan -var-file=008.tfvars -out=plan.out
terraform apply plan.out

cd ../ansible/
ansible-playbook -i all.host all.yml -vvvvv
```

### Execute (step by step) with explanation:

##### Terraform creates EC2 IAM ROLE, EC2, CloudWatch LogGroup, CloudWatch LogStream
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

Notice that terraform generate ../ansible/all.host file with public IP of EC2.
It will be used in next step for ansible.

##### Ansible update ubuntu repository
```
cd ../ansible/
ansible-playbook -i all.host ubuntu_update.yml -vvvvv
```

##### Ansible install java
```
ansible-playbook -i all.host install_jdk_ubuntu.yml -vvvvv
```

##### Ansible execute send and execute java application generating logs

```
ansible-playbook -i all.host copy_and_execute_jar.yml -vvvvv
```

Source of java application can be found [here](https://github.com/pgrabarczyk/spring-cloud/tree/master/spring-cloud-sleuth-scheduler)

Logs should be at:
```
/home/ubuntu/logs/spring-cloud-sleuth-scheduler.log
```

##### Ansible install agent for sending logs to cloudwatch

```
ansible-playbook -i all.host install_log_agent.yml -vvvvv
```

##### Logs in cloudwatch
Now you should be able to see logs using AWS console in Cloudwatch.
![cloudwatch](https://github.com/pgrabarczyk/devops/raw/master/008-aws-cloudwatch-kibana/img/cloudwatch.png)

### Clean up (Destroy AWS environment)
```
cd ../terraform
terraform destroy -var-file=002.tfvars
```

## Runned on configuration:
```
Terraform v0.10.7
ansible 2.4.0.0
python version = 2.7.12 (default, Nov 19 2016, 06:48:10) [GCC 5.4.0 20160609]
```

### Troubleshooting

##### "Permission denied (publickey)." when SSH to EC2
I generated ssh key using
```
ssh-keygen
```
and place it in my .ssh directory.
When terraform execute it's use this key.
In this case I don't have to set key param in ansbile/ssh.
