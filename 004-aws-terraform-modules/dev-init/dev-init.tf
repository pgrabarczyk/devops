module "vpc" {
  source = "../modules/vpc"
  appname = "${var.appname}"
  env = "${var.env}"
  aws_region = "${var.aws_region}"
}
module "key_pair" {
  source = "../modules/key_pair"
  key_name="${var.key_name}"
  public_key_path="${var.public_key_path}"
}
module "sg_developers" {
  source =  "../modules/security_group/developers"
  appname = "${var.appname}"
  env = "${var.env}"
  dev_CIDR_list = "${var.dev_CIDR_list}"
  vpc_id = "${module.vpc.id}"
}
module "sg_icmp_inside_vpc" {
  source =  "../modules/security_group/icmp_inside_vpc"
  appname = "${var.appname}"
  env = "${var.env}"
  vpc_cidr = "${var.vpc_cidr}"
  vpc_id = "${module.vpc.id}"
}
module "sg_jenkins_slave" {
  source =  "../modules/security_group/jenkins_slave"
  appname = "${var.appname}"
  env = "${var.env}"
  vpc_id = "${module.vpc.id}"
  master_CIDR = "${var.jenkins_master_CIDR}"
}
module "sg_jump_service" {
  source =  "../modules/security_group/jump_service"
  appname = "${var.appname}"
  env = "${var.env}"
  vpc_id = "${module.vpc.id}"
  in_ssh_security_groups = ["${module.sg_jenkins_slave.id}"]
}
module "sg_be_services" {
  source =  "../modules/security_group/be_services"
  appname = "${var.appname}"
  env = "${var.env}"
  vpc_id = "${module.vpc.id}"
  in_ssh_security_groups = ["${module.sg_jump_service.id}"]
  in_http_security_groups = [
    "${module.sg_jump_service.id}",
    "${module.sg_jenkins_slave.id}"
  ]
}
module "ec2_jenkins_slave" {
  source =  "../modules/ec2/jenkins_slave"
  appname = "${var.appname}"
  key_name = "${module.key_pair.id}"
  instance_type = "${var.jenkins_slave_instance_type}"
  public_ip = "${var.jenkins_slave_public_ip}"
  subnet_id = "${module.vpc.subnet_public_id}"
  vpc_security_group_ids = [
    "${module.sg_jenkins_slave.id}",
    "${module.sg_developers.id}",
    "${module.sg_icmp_inside_vpc.id}"
  ]
}
