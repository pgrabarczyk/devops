#General
appname="pgrabarczyk"
env="dev"

#Provider
aws_region="eu-west-1"
aws_shared_credentials_file="/home/patryk/.aws/credentials"
aws_profile="pgrabarczyk-sandbox"

#VPC
vpc_cidr="10.0.0.0/16"

#Subnet
subnet_public_cidr="10.0.1.0/24"
subnet_private_cidr="10.0.11.0/26"

#SecurityGroups
dev_CIDR_list=["0.0.0.0/0"] #Should be changed for security reasons onto your IP

#key_pair
key_name="pgrabarczyk"
public_key_path="/home/patryk/.ssh/pgrabarczyk.pub"

#ec2
jenkins_slave_instance_type="t2.medium"
#jenkins_slave_public_ip=
#jenkins_master_CIDR=
