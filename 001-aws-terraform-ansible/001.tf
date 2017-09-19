provider "aws" {
	region					        = "${var.aws_region}"
 	shared_credentials_file	= "${var.aws_shared_credentials_file}"
 	profile					        = "${var.aws_profile}"
}


# vpc

resource "aws_vpc" "vpc" {
    cidr_block = "10.1.0.0/16"
    tags {
      Name = "${var.appname}"
    }
}

resource "aws_internet_gateway" "igw" {
    vpc_id = "${aws_vpc.vpc.id}"
    tags {
      Name = "${var.appname}"
    }
}

resource "aws_route_table" "public" {
    vpc_id = "${aws_vpc.vpc.id}"
    route {
      cidr_block = "0.0.0.0/0"
      gateway_id = "${aws_internet_gateway.igw.id}"
    }
    tags {
      Name = "${var.appname}"
    }
}

## Subnets

resource "aws_subnet" "public" {
    vpc_id = "${aws_vpc.vpc.id}"
    cidr_block = "10.1.1.0/24"
    map_public_ip_on_launch = true
    availability_zone = "${var.aws_region}a"
    tags {
      Name = "${var.appname}-public"
    }
}

resource "aws_subnet" "subnet_rds1" {
  vpc_id = "${aws_vpc.vpc.id}"
  cidr_block = "10.1.2.0/24"
  map_public_ip_on_launch = false
  availability_zone = "${var.aws_region}a"
  tags {
    Name = "${var.appname}-rds1"
  }
}

resource "aws_subnet" "subnet_rds2" {
  vpc_id = "${aws_vpc.vpc.id}"
  cidr_block = "10.1.3.0/24"
  map_public_ip_on_launch = false
  availability_zone = "${var.aws_region}b"
  tags {
    Name = "${var.appname}-rds2"
  }
}

resource "aws_route_table_association" "public_assoc" {
  subnet_id = "${aws_subnet.public.id}"
  route_table_id = "${aws_route_table.public.id}"
}

resource "aws_db_subnet_group" "rds_subnetgroup" {
  name = "rds_subnetgroup"
  subnet_ids = ["${aws_subnet.subnet_rds1.id}", "${aws_subnet.subnet_rds2.id}"]
}

## Security groups
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
