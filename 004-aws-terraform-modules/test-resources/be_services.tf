## TODO should be private
module "ec2_discovery" {
	source =  "../modules/ec2/be_service"
	service = "discovery"
	associate_public_ip_address = true #TODO false

	appname = "${var.appname}"
	env = "${var.env}"
	build_id = "${var.build_id}"
	instance_type = "${var.be_service_instance_type}"
	key_name = "${var.be_service_keyname}"

	subnet_id = "${data.aws_subnet.public.id}" #TODO private
	vpc_security_group_ids = ["${data.aws_security_group.be_services.id}"]
}
### PUBLIC
module "ec2_gateway" {
	source =  "../modules/ec2/be_service"
	service = "gateway"
	associate_public_ip_address = true

	appname = "${var.appname}"
	env = "${var.env}"
	build_id = "${var.build_id}"
	instance_type = "${var.be_service_instance_type}"
	key_name = "${var.be_service_keyname}"

	subnet_id = "${data.aws_subnet.public.id}"
	vpc_security_group_ids = ["${data.aws_security_group.be_services.id}"]
}
### PRIVATE
module "ec2_config" {
	source =  "../modules/ec2/be_service"
	service = "config"
	associate_public_ip_address = false

	appname = "${var.appname}"
	env = "${var.env}"
	build_id = "${var.build_id}"
	instance_type = "${var.be_service_instance_type}"
	key_name = "${var.be_service_keyname}"

	subnet_id = "${data.aws_subnet.private.id}"
	vpc_security_group_ids = ["${data.aws_security_group.be_services.id}"]
}
module "ec2_linkedin_users" {
	source =  "../modules/ec2/be_service"
	service = "linkedin-users"
	associate_public_ip_address = false

	appname = "${var.appname}"
	env = "${var.env}"
	build_id = "${var.build_id}"
	instance_type = "${var.be_service_instance_type}"
	key_name = "${var.be_service_keyname}"

	subnet_id = "${data.aws_subnet.private.id}"
	vpc_security_group_ids = ["${data.aws_security_group.be_services.id}"]
}
module "ec2_proxy_provider" {
	source =  "../modules/ec2/be_service"
	service = "proxy-provider"
	associate_public_ip_address = false

	appname = "${var.appname}"
	env = "${var.env}"
	build_id = "${var.build_id}"
	instance_type = "${var.be_service_instance_type}"
	key_name = "${var.be_service_keyname}"

	subnet_id = "${data.aws_subnet.private.id}"
	vpc_security_group_ids = ["${data.aws_security_group.be_services.id}"]
}
