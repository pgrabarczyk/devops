resource "aws_security_group" "be_services" {
  name = "${var.appname}-sg-be-services"
  description = "sg for backend services"
  vpc_id = "${var.vpc_id}"

  #HTTP 8080
  ingress {
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    security_groups = ["${var.in_http_security_groups}"]
    self = true
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    security_groups = ["${var.in_ssh_security_groups}"]
  }

  tags {
    Name = "${var.appname}-${var.env}-sg-be-services"
    Environment = "${var.env}"
    Project = "${var.appname}"
  }
}
