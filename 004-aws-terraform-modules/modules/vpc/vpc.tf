# vpc
resource "aws_vpc" "vpc" {
    cidr_block = "${var.vpc_cidr}"
    tags {
      Name = "${var.appname}-${var.env}"
      Environment = "${var.env}"
      Project = "${var.appname}"
    }
}

## Subnets
resource "aws_subnet" "public" {
    vpc_id = "${aws_vpc.vpc.id}"
    cidr_block = "${var.subnet_public_cidr}"
    map_public_ip_on_launch = true
    availability_zone = "${var.aws_region}a"
    tags {
      Name = "${var.appname}-${var.env}-public-subnet"
      Environment = "${var.env}"
      Project = "${var.appname}"
    }
}

resource "aws_subnet" "private" {
    vpc_id = "${aws_vpc.vpc.id}"
    cidr_block = "${var.subnet_private_cidr}"
    map_public_ip_on_launch = false
    availability_zone = "${var.aws_region}b"
    tags {
      Name = "${var.appname}-${var.env}-private-subnet"
      Environment = "${var.env}"
      Project = "${var.appname}"
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
      Name = "${var.appname}-${var.env}-internet-gateway"
      Environment = "${var.env}"
      Project = "${var.appname}"
    }
}

resource "aws_nat_gateway" "nat_gw" {
    allocation_id = "${aws_eip.nat_gw.id}"
    subnet_id = "${aws_subnet.public.id}"
    tags {
      Name = "${var.appname}-${var.env}-nat-gateway"
      Environment = "${var.env}"
      Project = "${var.appname}"
    }
}

resource "aws_route_table" "public" {
    vpc_id = "${aws_vpc.vpc.id}"
    route {
      cidr_block = "0.0.0.0/0"
      gateway_id = "${aws_internet_gateway.i_gw.id}"
    }
    tags {
      Name = "${var.appname}-${var.env}-route-table-public"
      Environment = "${var.env}"
      Project = "${var.appname}"
    }
}

resource "aws_route_table" "private" {
    vpc_id = "${aws_vpc.vpc.id}"
    route {
      cidr_block = "0.0.0.0/0"
      nat_gateway_id = "${aws_nat_gateway.nat_gw.id}"
    }
    tags {
      Name = "${var.appname}-${var.env}-route-table-private"
      Environment = "${var.env}"
      Project = "${var.appname}"
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
