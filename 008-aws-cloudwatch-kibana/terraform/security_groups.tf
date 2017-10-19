resource "aws_security_group" "service" {
  name = "${var.appname}_sg_service"
  description = "sg for service"
  vpc_id = "${aws_vpc.vpc.id}"

  #SSH
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["${var.devCIDR}"]
  }
  #HTTP
  ingress {
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = ["${var.devCIDR}"]
  }
  #ICMP
  ingress {
    from_port = "-1"
    to_port = "-1"
    protocol = "icmp"
    cidr_blocks = ["${var.devCIDR}"]
  }
  #All traffic for outbound
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags {
    Name = "${var.appname}_sg_service"
  }
}
