#General
variable "appname" {
  description = "Name for your app. Will be as prefix in Tag:Name and will be equals Tag:Project"
}
variable "env" {
  description = "Environment (eg. test/dev/prod). WIll be in tag:Environment and as part of Tag:Name"
}

variable "aws_region" {}

#VPC
variable "vpc_cidr" {
  default="10.0.0.0/16"
}

#Subnet
variable "subnet_public_cidr" {
  description = "Public subnet CIDR"
  default="10.0.1.0/24"
}
variable "subnet_private_cidr" {
  description = "Private subnet CIDR"
  default="10.0.11.0/26"
}
