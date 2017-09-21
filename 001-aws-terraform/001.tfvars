#Provider
aws_region="eu-west-1"
aws_shared_credentials_file="/home/patryk/.aws/credentials"
aws_profile="pgrabarczyk-sandbox"

#SecurityGroups
devCIDR="0.0.0.0/0" #Should be changed for security reasons onto your IP
appname="pgrabarczyk"

#RDS
db_instance_class="db.t1.micro"
db_name="dbname"
db_username="root"
db_password="rootpassword"

#key_pair
key_name="pgrabarczyk-sandbox"
public_key_path="/home/patryk/.ssh/pgrabarczyk-sandbox.pub"

#ec2
dev_instance_type="t2.micro"
dev_ami="ami-785db401"
