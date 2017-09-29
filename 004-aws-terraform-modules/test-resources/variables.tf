#General
variable "appname" {
  description = "Name for your app. Will be as prefix in Tag:Name and will be equals Tag:Project"
}
variable "env" {
  description = "Environment (eg. test/dev/prod). WIll be in tag:Environment and as part of Tag:Name"
}
variable "search_env" {
  description = "AWS Services will be filtered using this as Tag:Environment"
}
variable "build_id" {
  description = "Build id - will be used as tag"
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

#EC2
variable "be_service_instance_type" {
  description = "AWS EC2 instance_type for backend services"
  default = "t2.micro"
}
variable "be_service_keyname" {
  description = "Key pair name exists in AWS for backend services"
}

variable "jump_service_instance_type" {
  description = "AWS EC2 instance_type for jump service"
  default = "t2.micro"
}
variable "jump_service_keyname" {
  description = "Key pair name exists in AWS for jump service"
}
