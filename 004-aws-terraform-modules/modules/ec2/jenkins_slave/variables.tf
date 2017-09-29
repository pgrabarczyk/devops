variable "appname" {
  description = "Name for your app. Will be as prefix in Tag:Name and will be equals Tag:Project"
}
variable "instance_type" {
  description = "AWS EC2 instance_type"
  default = "t2.micro"
}
variable "public_ip" {
  description = "Existing EIP which will be attached to this instance"
}
variable "key_name" {
  description = "Key pair name exists in AWS"
}
variable "subnet_id" {
  description = "Subnet inside which this EC2 will be created"
}
variable "vpc_security_group_ids" {
  type = "list"
  description = "Security Groups IDs which will be attached to this EC2"
}
