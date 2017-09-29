resource "aws_security_group" "icmp_inside_vpc" {
  name = "${var.appname}-${var.env}-sg-icmp-inside-vpc"
  description = "SG for developers"
  vpc_id = "${var.vpc_id}"

  #ICMP
  ingress {
    from_port = "-1"
    to_port = "-1"
    protocol = "icmp"
    cidr_blocks = ["${var.vpc_cidr}"]
  }
  #ICMP
  egress {
    from_port = "-1"
    to_port = "-1"
    protocol = "icmp"
    cidr_blocks = ["${var.vpc_cidr}"]
  }

  tags {
    Name = "${var.appname}-${var.env}-sg-icmp-inside-vpc"
    Environment = "${var.env}"
    Project = "${var.appname}"
  }
}
