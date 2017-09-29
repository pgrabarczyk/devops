data "aws_ami" "be_service" {
	most_recent = true

	filter {
		name   = "tag:Name"
		values = ["${var.appname}-be-service"]
	}
	filter {
		name   = "tag:Service"
		values = ["be-service"]
	}

	owners = ["self"]
}

resource "aws_instance" "be_service" {
	ami                          = "${data.aws_ami.be_service.id}"
	instance_type                = "${var.instance_type}"
	subnet_id				             = "${var.subnet_id}"
	vpc_security_group_ids	     = ["${var.vpc_security_group_ids}"]
	key_name				             = "${var.key_name}"
	associate_public_ip_address  = "${var.associate_public_ip_address}"

	tags {
		Name = "${var.appname}-${var.env}-${var.service}"
    Project = "${var.appname}"
		Environment = "${var.env}"
		Service = "${var.service}"
		BuildID = "${var.build_id}"
	}
}
