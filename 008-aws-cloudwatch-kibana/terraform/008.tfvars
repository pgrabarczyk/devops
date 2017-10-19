#Provider
aws_region="eu-west-1"
aws_shared_credentials_file="/home/pgrabarczyk/.aws/credentials"
aws_profile="pgrabarczyk-sandbox"

#SecurityGroups
devCIDR="0.0.0.0/0" #Should be changed for security reasons onto your IP
appname="pgrabarczyk"

#key_pair
key_name="pgrabarczyk-sandbox"
public_key_path="/home/pgrabarczyk/.ssh/pgrabarczyk-sandbox.pub"

#ec2
ec2_instance_type="t2.micro"

#cloudwatch
log_group_name="pgrabarczyk-lg"
log_stream_name="pgrabarczyk-ls"

#IAM
log_role_name="EC2-log-role"
log_policy_name="cloudwatch-log-policy"
