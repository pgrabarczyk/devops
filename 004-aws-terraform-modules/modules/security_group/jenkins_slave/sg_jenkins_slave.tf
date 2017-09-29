resource "aws_security_group" "jenkins_slave" {
  name = "${var.appname}-${var.env}-sg-jenkins-slave"
  description = "SG for jenkins slave"
  vpc_id = "${var.vpc_id}"

  #SSH
  ingress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["${var.master_CIDR}"]
  }
  #All traffic for outbound
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "${var.appname}-${var.env}-sg-jenkins-slave"
    Environment = "${var.env}"
    Project = "${var.appname}"
  }
}
