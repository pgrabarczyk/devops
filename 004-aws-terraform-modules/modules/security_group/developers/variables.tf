variable "appname" {
  description = "Name for your app. Will be as prefix in Tag:Name and will be equals Tag:Project"
}
variable "env" {
  description = "Environment (eg. test/dev/prod). WIll be in tag:Environment and as part of Tag:Name"
}
variable "dev_CIDR_list" {
  description = "CIDR of developers IPS"
}
variable "vpc_id" {
  description = "VPC ID"
}
