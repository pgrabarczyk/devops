data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "jump_service" {
  instance_type = "${var.ec2_instance_type}"
  ami = "${data.aws_ami.ubuntu.id}"
  tags {
    Name = "${var.appname}_jump_service"
  }
  key_name = "${aws_key_pair.auth.id}"
  vpc_security_group_ids = ["${aws_security_group.jump_service.id}"]
  subnet_id = "${aws_subnet.public.id}"
}

resource "aws_instance" "backend_services" {
  instance_type = "${var.ec2_instance_type}"
  ami = "${data.aws_ami.ubuntu.id}"
  tags {
    Name = "${var.appname}_backend_services"
  }
  key_name = "${aws_key_pair.auth.id}"
  vpc_security_group_ids = ["${aws_security_group.backend_services.id}"]
  subnet_id = "${aws_subnet.public.id}"
}
