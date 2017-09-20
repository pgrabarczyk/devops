# vpc
resource "aws_vpc" "vpc" {
    cidr_block = "10.0.0.0/16"
    tags {
      Name = "${var.appname}"
    }
}

## Subnets
resource "aws_subnet" "public" {
    vpc_id = "${aws_vpc.vpc.id}"
    cidr_block = "10.0.1.0/24"
    map_public_ip_on_launch = true
    availability_zone = "${var.aws_region}a"
    tags {
      Name = "${var.appname}-public"
    }
}

resource "aws_subnet" "private" {
    vpc_id = "${aws_vpc.vpc.id}"
    cidr_block = "10.0.11.0/26"
    map_public_ip_on_launch = false
    availability_zone = "${var.aws_region}b"
    tags {
      Name = "${var.appname}-private"
    }
}

## Elastic IP
resource "aws_eip" "nat_gw" {
    vpc = true
}

## Route Tables
resource "aws_internet_gateway" "i_gw" {
    vpc_id = "${aws_vpc.vpc.id}"
    tags {
      Name = "${var.appname}"
    }
}

resource "aws_nat_gateway" "nat_gw" {
    allocation_id = "${aws_eip.nat_gw.id}"
    subnet_id = "${aws_subnet.public.id}"
}

resource "aws_route_table" "public" {
    vpc_id = "${aws_vpc.vpc.id}"
    route {
      cidr_block = "0.0.0.0/0"
      gateway_id = "${aws_internet_gateway.i_gw.id}"
    }
    tags {
      Name = "${var.appname}"
    }
}

resource "aws_route_table" "private" {
    vpc_id = "${aws_vpc.vpc.id}"
    route {
      cidr_block = "0.0.0.0/0"
      nat_gateway_id = "${aws_nat_gateway.nat_gw.id}"
    }
    tags {
      Name = "${var.appname}"
    }
}

## Route table association
resource "aws_route_table_association" "public" {
  subnet_id = "${aws_subnet.public.id}"
  route_table_id = "${aws_route_table.public.id}"
}

resource "aws_route_table_association" "private" {
  subnet_id = "${aws_subnet.private.id}"
  route_table_id = "${aws_route_table.private.id}"
}
