# 008-aws-cloudwatch-kibana

### Project in progress / TODO

- refactor terraform
- results of elasticsearch (screenshoot?) in readme
- refactor ansible playbook
- refactor to keep ansible and terraform settings (eg. region in 1 file)

### Execute

```
cd terraform
terraform init
terraform plan -var-file=008.tfvars -out=plan.out
terraform apply plan.out
```
Terraform will execute ansible while creating EC2

### Explanation of execution (step by step):

#### Terraform execution

Execute of Terraform apply creates:
- VPC
- Subnet
- Security Group
- Key Pair
- EC2 IAM ROLE,
- EC2
- CloudWatch LogGroup
- CloudWatch LogStream

IAM Role for EC2 with policy looks:
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

Notice that terraform generate files:
- ../ansible/all.host file with public IP of EC2.
- ../ansible/script/aws_ec2_wait.sh script that will use AWS CLI to wait for EC2 status

Then terraform execute ansible main playbook.
You can check for ansible logs in
```
ansbile/ansible.log
```

#### Ansible execution

Ansible main playbook executes following playbooks

##### wait_for_ec2.yml

Will execute script script/aws_ec2_wait.sh and wait for ready ec2

##### ubuntu_update.yml

Will update ubuntu repository

##### install_jdk_ubuntu.yml

Will install jdk

##### copy_and_execute_jar.yml

Will copy and execute java application that generating logs

Source of java application can be found [here](https://github.com/pgrabarczyk/spring-cloud/tree/master/spring-cloud-sleuth-scheduler)

Logs should be in:
```
/home/ubuntu/logs/spring-cloud-sleuth-scheduler.log
```

##### install_log_agent.yml

Will install agent for sending logs to cloudwatch

##### Logs in cloudwatch
Now you should be able to see logs using AWS console in Cloudwatch.
![cloudwatch](https://github.com/pgrabarczyk/devops/raw/master/008-aws-cloudwatch-kibana/img/cloudwatch.png)

### Clean up (Destroy AWS environment)
```
cd ../terraform
terraform destroy -var-file=008.tfvars
```

## Runned on configuration:
```
Terraform v0.10.7

ansible 2.4.0.0
python version = 2.7.12 (default, Nov 19 2016, 06:48:10) [GCC 5.4.0 20160609]

aws-cli/1.11.13 Python/3.5.2 Linux/4.10.0-37-generic botocore/1.4.70
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

##### Ansible want to exchange ssh key while executing script and I cannot find when
Disable key exchange using shell command:

```
export ANSIBLE_HOST_KEY_CHECKING=False
```