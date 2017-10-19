#Provider
variable "aws_region" {}
variable "aws_shared_credentials_file" {}
variable "aws_profile" {}

#SecurityGroups
variable "devCIDR" {}
variable "appname" {}

#key_pair
variable "key_name" {}
variable "public_key_path" {}

#ec2
variable "ec2_instance_type" {}

#cloudwatch
variable "log_group_name" {}
variable "log_stream_name" {}

#IAM
variable "log_role_name" {}
variable "log_policy_name" {}
