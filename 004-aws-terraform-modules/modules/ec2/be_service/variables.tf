variable "appname" {
  description = "Name for your app. Will be as prefix in Tag:Name and will be equals Tag:Project"
}
variable "env" {
  description = "Environment (eg. test/dev/prod). WIll be in tag:Environment and as part of Tag:Name"
}
variable "service" {
  description = "Service name of BE service - will be set as Tag:Service"
}
variable "build_id" {
  description = "Build id - will be used as tag"
}
variable "instance_type" {
  description = "AWS EC2 instance_type"
  default = "t2.micro"
}
variable "subnet_id" {
  description = "Subnet inside which this EC2 will be created"
}
variable "vpc_security_group_ids" {
  type = "list"
  description = "Security Groups IDs which will be attached to this EC2"
}
variable "key_name" {
  description = "Key pair name exists in AWS"
}
variable "associate_public_ip_address" {
  description = "true/false - should public ip be associated"
}
