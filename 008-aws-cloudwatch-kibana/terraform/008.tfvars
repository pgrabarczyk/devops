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
ec2_log_role_name="EC2-cloudwatch-role"
ec2_log_policy_name="ec2-cloudwatch-policy"

es_log_role_name="lambda-elasticsearch-role"
es_log_policy_name="lambda-elasticsearch-policy"

#Lambda
lambda_name="LogsToElasticsearch"
lambda_permission_principal="logs.eu-west-1.amazonaws.com"
lambda_function_name="cwl2es" #filename of .js where is source of lambda
lambda_filename_zip="cwl2eslambda.zip"