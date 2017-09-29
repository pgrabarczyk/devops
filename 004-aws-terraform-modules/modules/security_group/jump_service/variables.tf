variable "appname" {
  description = "Name for your app. Will be as prefix in Tag:Name and will be equals Tag:Project"
}
variable "env" {
  description = "Environment (eg. test/dev/prod). WIll be in tag:Environment and as part of Tag:Name"
}
variable "in_ssh_security_groups" {
  type = "list"
  description = "IDs of security groups which can access this security group via SSH (22)"
}
variable "vpc_id" {
  description = "VPC ID"
}
