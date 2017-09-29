resource "aws_security_group" "jump_service" {
  name = "${var.appname}-${var.env}-sg-jump-service"
  description = "SG for jump service"
  vpc_id = "${var.vpc_id}"

  #SSH
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    security_groups = ["${var.in_ssh_security_groups}"]
  }
  #All traffic for outbound
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "${var.appname}-${var.env}-sg-jump-service"
    Environment = "${var.env}"
    Project = "${var.appname}"
  }
}
