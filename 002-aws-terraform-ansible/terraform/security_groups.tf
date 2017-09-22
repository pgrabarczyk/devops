resource "aws_security_group" "jump_service" {
  name = "${var.appname}_sg_jump_service"
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
    Name = "${var.appname}_sg_jump_service"
  }
}

resource "aws_security_group" "elb" {
  name = "${var.appname}_sg_elb"
  description = "sg for elb"
  vpc_id = "${aws_vpc.vpc.id}"

  #HTTP 80
  ingress {
    from_port = 0
    to_port = 65535
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
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
    Name = "${var.appname}_sg_elb"
  }
}

resource "aws_security_group" "backend_services" {
  name = "${var.appname}_sg_backend_service"
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
    from_port = "-1"
    to_port = "-1"
    protocol = "icmp"
    security_groups = ["${aws_security_group.jump_service.id}"]
  }
  #HTTP 8080 for LB
  ingress {
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    security_groups = ["${aws_security_group.elb.id}"]
  }
  #All traffic for outbound
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags {
    Name = "${var.appname}_sg_backend_service"
  }
}
