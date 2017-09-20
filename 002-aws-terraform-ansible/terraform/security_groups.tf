resource "aws_security_group" "jump_service" {
  name = "jump_service"
  description = "sg for jump_service"
  vpc_id = "${aws_vpc.vpc.id}"

  #SSH
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["${var.devCIDR}"]
  }
  #ICMP
  ingress {
    from_port = 8
    to_port = 0
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
    Name = "${var.appname}-sg_jump_service"
  }
}

resource "aws_security_group" "backend_services" {
  name = "backend_service"
  description = "sg for backend_service"
  vpc_id = "${aws_vpc.vpc.id}"

  #SSH
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    security_groups = ["${aws_security_group.jump_service.id}"]
  }
  #ICMP
  ingress {
    from_port = 8
    to_port = 0
    protocol = "icmp"
    security_groups = ["${aws_security_group.jump_service.id}"]
  }
  #HTTP for LB TODO
  #All traffic for outbound
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags {
    Name = "${var.appname}-sg_backend_service"
  }
}
