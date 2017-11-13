# 010-packer-ansible

Create AMI using [packer](https://www.packer.io)

## Execute

##### 1. Set in config.json:
```
"region": <REGION>,
"source_ami": <AMI_OF_UBUNTU>,
```

I used ubuntu 16.04 LTS in Ireland.

##### 2. Set your AWS credentials as environment:
(option a) aws_access_key and aws_secret_key:

```
$ export aws_access_key=XXXX
$ export aws_secret_key=XXXX
```

(option b) use your credientials from "aws configuration".
In my case ~/.aws/credentials
and set specified profile (if not default)
```
export AWS_PROFILE=pgrabarczyk-sandbox
```

##### 3. Now you can execute:

```
packer build config.json
```

##### 4. At the end you should see something like:
```
==> Builds finished. The artifacts of successful builds are:
--> amazon-ebs: AMIs were created:
eu-west-1: ami-5cb36e25
```

##### 5. Then in your console should exists created AMI:
![draw_007](https://github.com/pgrabarczyk/devops/raw/master/007-packer-create-ami/images/aws_consolepng.png)

Now you can create EC2 from new AMI then execute:
```text
java -version
java version "1.8.0_151"
Java(TM) SE Runtime Environment (build 1.8.0_151-b12)
Java HotSpot(TM) 64-Bit Server VM (build 25.151-b12, mixed mode)
```

## Executed on configuration:
```
packer 1.1.0
ansible 2.4.0.0
  python version = 2.7.12 (default, Nov 19 2016, 06:48:10) [GCC 5.4.0 20160609]

```
