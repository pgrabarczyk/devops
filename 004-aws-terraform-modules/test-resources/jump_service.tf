module "ec2_jump_service" {
  source =  "../modules/ec2/jump_service"
  appname = "${var.appname}"
  env = "${var.env}"
  build_id = "${var.build_id}"
  key_name = "${var.jump_service_keyname}"
  instance_type = "${var.jump_service_instance_type}"
  subnet_id = "${data.aws_subnet.public.id}"
  vpc_security_group_ids = [
    "${data.aws_security_group.sg_jump_service.id}",
    "${data.aws_security_group.sg_developers.id}",
    "${data.aws_security_group.sg_icmp_inside_vpc.id}"
  ]
}
