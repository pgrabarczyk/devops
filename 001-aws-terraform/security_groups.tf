resource "aws_security_group" "ec2_public" {
  name = "sg_ec2_public"
  description = "EC2 public security group"
  vpc_id = "${aws_vpc.vpc.id}"

  #SSH
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["${var.devCIDR}"]
  }
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags {
    Name = "${var.appname}-sg_ec2_public"
  }
}

resource "aws_security_group" "ec2_private" {
  name = "sg_ec2_private"
  description = "EC2 private security group"
  vpc_id = "${aws_vpc.vpc.id}"

  #SSH
  ingress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["10.1.0.0/16"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags {
    Name = "${var.appname}-sg_ec2_private"
  }
}

resource "aws_security_group" "rds" {
  name = "sg_rds"
  description = "RDS security group"
  vpc_id = "${aws_vpc.vpc.id}"

  #SSH
  ingress {
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    security_groups = ["${aws_security_group.ec2_public.id}", "${aws_security_group.ec2_private.id}"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags {
    Name = "${var.appname}-sg_rds"
  }
}
