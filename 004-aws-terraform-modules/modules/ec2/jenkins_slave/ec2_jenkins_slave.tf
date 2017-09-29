data "aws_eip" "jenkins_slave" {
  public_ip = "${var.public_ip}"
}

data "aws_ami" "jenkins_slave" {
	most_recent = true

	filter {
		name   = "tag:Name"
		values = ["${var.appname}-jenkins-slave"]
	}
	filter {
		name   = "tag:Service"
		values = ["jenkins-slave"]
	}

	owners   = ["self"]
}

resource "aws_instance" "jenkins_slave" {
  instance_type = "${var.instance_type}"
  ami = "${data.aws_ami.jenkins_slave.id}"
  key_name = "${var.key_name}"
  vpc_security_group_ids = ["${var.vpc_security_group_ids}"]
  subnet_id = "${var.subnet_id}"

  tags {
    Name = "${var.appname}-jenkins-slave"
    Project = "${var.appname}"
    Service = "jenkins-slave"
  }

}

resource "aws_eip_association" "jenkins_slave" {
  instance_id   = "${aws_instance.jenkins_slave.id}"
  allocation_id = "${data.aws_eip.jenkins_slave.id}"
}
