data "aws_ami" "jump_service" {
	most_recent = true

	filter {
		name   = "tag:Name"
		values = ["${var.appname}-jump-service"]
	}
  filter {
    name   = "tag:Service"
    values = ["jump-service"]
  }

	owners   = ["self"]
}

resource "aws_instance" "jump_service" {
  instance_type = "${var.instance_type}"
  ami = "${data.aws_ami.jump_service.id}"
  key_name = "${var.key_name}"
  vpc_security_group_ids = ["${var.vpc_security_group_ids}"]
  subnet_id = "${var.subnet_id}"

  tags {
    Name = "${var.appname}-${var.env}-jump-service"
    Project = "${var.appname}"
		Environment = "${var.env}"
		Service = "jump-service"
		BuildID = "${var.build_id}"
  }
}
