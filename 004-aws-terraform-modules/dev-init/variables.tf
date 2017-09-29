#General
variable "appname" {
  description = "Name for your app. Will be as prefix in Tag:Name and will be equals Tag:Project"
}
variable "env" {
  description = "Environment (eg. test/dev/prod). WIll be in tag:Environment and as part of Tag:Name"
}

#Provider
variable "aws_region" {
  description = "AWS region"
  default = "eu-west-1"
}
variable "aws_shared_credentials_file" {
  description = "Path to credentials file"
}
variable "aws_profile" {
  description = "AWS profile used to connection"
}

#VPC
variable "vpc_cidr" {
  description = "CIDR of VPC"
  default = "10.0.0.0/16"
}

#Subnet
variable "subnet_public_cidr" {
  description = "CIDR for public subnet"
}
variable "subnet_private_cidr" {
  description = "CIDR for private subnet"
}

#SecurityGroups
variable "dev_CIDR_list" {
  type = "list"
  description = "CIDR of developers IPS"
}

#key_pair
variable "key_name" {
  description = "Key pair name"
}
variable "public_key_path" {
  description = "Key pair path to upload"
}

#ec2
variable "jenkins_slave_instance_type" {
  description = "AWS EC2 instance_type for jenkins slave"
  default = "t2.medium"
}
variable "jenkins_slave_public_ip" {
  description = "Existing EIP which will be attached to this instance"
}
variable "jenkins_master_CIDR" {
  description = "CIDR of jenkins master"
}
