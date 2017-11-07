#Provider
variable "aws_region" {}
variable "aws_profile" {}

#General
variable "appname" {}

#EC2
variable "ec2_instance_type" {}

variable "subnet_id" {}

variable "ec2_log_role_name" {}
variable "ec2_log_policy_name" {}

#Security Group
variable "vpc_id" {}
variable "devCIDR" {}

#key_pair
variable "key_name" {}
variable "public_key_path" {}

#cloudwatch
variable "log_group_name" {}
variable "log_stream_name" {}