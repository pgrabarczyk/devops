variable "appname" {
  description = "Name for your app. Will be as prefix in Tag:Name and will be equals Tag:Project"
}
variable "env" {
  description = "Environment (eg. test/dev/prod). WIll be in tag:Environment and as part of Tag:Name"
}
variable "master_CIDR" {
  description = "CIDR of jenkins master"
}
variable "vpc_id" {
  description = "VPC ID"
}
