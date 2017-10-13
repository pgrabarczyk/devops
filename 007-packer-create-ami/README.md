# 007-packer-create-ami

Create AMI using [packer](https://www.packer.io)

## Execute

1) set in config.json:
```
"region": <REGION>,
"source_ami": <AMI_OF_UBUNTU>,
```

I used ubuntu 16.04 LTS in Ireland.

2) set your AWS credentials as environment:

a) set your AWS credentials as environment (aws_access_key and aws_secret_key):

```
$ export aws_access_key=XXXX
$ export aws_secret_key=XXXX
```

b) use your credientials from "aws configuration".
In my case ~/.aws/credentials
and set specified profile (if not default)
```
export AWS_PROFILE=pgrabarczyk-sandbox
```

Now you can execute:

```
packer build config.json
```

At the end you should see something like:
```
==> Builds finished. The artifacts of successful builds are:
--> amazon-ebs: AMIs were created:
eu-west-1: ami-5cb36e25
```

Then in your console should exists created AMI:
TODO image


## Executed on configuration:
```
packer 1.1.0
```
