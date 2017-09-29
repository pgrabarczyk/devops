resource "aws_security_group" "dev" {
  name = "${var.appname}-${var.env}-sg-developers"
  description = "SG for developers"
  vpc_id = "${var.vpc_id}"

  #SSH
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["${var.dev_CIDR_list}"]
  }
  #ICMP
  ingress {
    from_port = "-1"
    to_port = "-1"
    protocol = "icmp"
    cidr_blocks = ["${var.dev_CIDR_list}"]
  }

  tags {
    Name = "${var.appname}-${var.env}-sg-developers"
    Environment = "${var.env}"
    Project = "${var.appname}"
  }
}
