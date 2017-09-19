#Provider
variable "aws_region" {}
variable "aws_shared_credentials_file" {}
variable "aws_profile" {}

#SecurityGroups
variable "devCIDR" {}
variable "appname" {}

#RDS
variable "db_instance_class" {}
variable "db_name" {}
variable "db_username" {}
variable "db_password" {}

#key_pair
variable "key_name" {}
variable "public_key_path" {}

#ec2
variable "dev_instance_type" {}
variable "dev_ami" {}
