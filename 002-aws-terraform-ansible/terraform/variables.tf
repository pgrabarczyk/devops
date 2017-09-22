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

#elb
variable "elb_healthy_threshold" {}
variable "elb_unhealthy_threshold" {}
variable "elb_timeout" {}
variable "elb_interval" {} 
