data "aws_subnet" "public" {
	filter {
		name   = "tag:Name"
		values = ["${var.appname}-${var.search_env}-public-subnet"]
	}
	filter {
		name   = "tag:Environment"
		values = ["${var.search_env}"]
	}
	filter {
		name   = "tag:Project"
		values = ["${var.appname}"]
	}
}

data "aws_subnet" "private" {
	filter {
		name   = "tag:Name"
		values = ["${var.appname}-${var.search_env}-private-subnet"]
	}
	filter {
		name   = "tag:Environment"
		values = ["${var.search_env}"]
	}
	filter {
		name   = "tag:Project"
		values = ["${var.appname}"]
	}
}

data "aws_security_group" "be_services" {
	filter {
		name   = "tag:Name"
		values = ["${var.appname}-${var.search_env}-sg-be-services"]
	}
	filter {
		name   = "tag:Environment"
		values = ["${var.search_env}"]
	}
	filter {
		name   = "tag:Project"
		values = ["${var.appname}"]
	}
}

data "aws_security_group" "sg_jenkins_slave" {
	filter {
		name   = "tag:Name"
		values = ["${var.appname}-${var.search_env}-sg-jenkins-slave"]
	}
	filter {
		name   = "tag:Environment"
		values = ["${var.search_env}"]
	}
	filter {
		name   = "tag:Project"
		values = ["${var.appname}"]
	}
}

data "aws_security_group" "sg_jump_service" {
	filter {
		name   = "tag:Name"
		values = ["${var.appname}-${var.search_env}-sg-jump-service"]
	}
	filter {
		name   = "tag:Environment"
		values = ["${var.search_env}"]
	}
	filter {
		name   = "tag:Project"
		values = ["${var.appname}"]
	}
}

data "aws_security_group" "sg_developers" {
	filter {
		name   = "tag:Name"
		values = ["${var.appname}-${var.search_env}-sg-developers"]
	}
	filter {
		name   = "tag:Environment"
		values = ["${var.search_env}"]
	}
	filter {
		name   = "tag:Project"
		values = ["${var.appname}"]
	}
}

data "aws_security_group" "sg_icmp_inside_vpc" {
	filter {
		name   = "tag:Name"
		values = ["${var.appname}-${var.search_env}-sg-icmp-inside-vpc"]
	}
	filter {
		name   = "tag:Environment"
		values = ["${var.search_env}"]
	}
	filter {
		name   = "tag:Project"
		values = ["${var.appname}"]
	}
}
