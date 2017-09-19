resource "aws_instance" "dev" {
  instance_type = "${var.dev_instance_type}"
  ami = "${var.dev_ami}"
  tags {
    Name = "${var.appname}"
  }
  key_name = "${aws_key_pair.auth.id}"
  vpc_security_group_ids = ["${aws_security_group.ec2_public.id}", "${aws_security_group.ec2_private.id}"]
  subnet_id = "${aws_subnet.public.id}"
}
