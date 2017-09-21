data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "jump_service" {
  instance_type = "${var.ec2_instance_type}"
  ami = "${data.aws_ami.ubuntu.id}"
  key_name = "${aws_key_pair.auth.id}"
  vpc_security_group_ids = ["${aws_security_group.jump_service.id}"]
  subnet_id = "${aws_subnet.public.id}"

  tags {
    Name = "${var.appname}_jump_service"
  }
}

resource "aws_instance" "backend_services" {
  instance_type = "${var.ec2_instance_type}"
  ami = "${data.aws_ami.ubuntu.id}"
  key_name = "${aws_key_pair.auth.id}"
  vpc_security_group_ids = ["${aws_security_group.backend_services.id}"]
  subnet_id = "${aws_subnet.private.id}"

  tags {
    Name = "${var.appname}_backend_services"
  }

  provisioner "local-exec" {
    command = <<EOP
cat > ../ansible/all.host <<'EOF'
[jump_service]
${aws_instance.jump_service.public_ip}
[jump_service:vars]
ansible_python_interpreter=/usr/bin/python3
[backend_services]
${aws_instance.backend_services.private_ip}
[backend_services:vars]
ansible_python_interpreter=/usr/bin/python3
ansible_ssh_common_args='-o ProxyCommand=\"ssh -W %h:%p -q ubuntu@${aws_instance.jump_service.public_ip}\"'
EOF
EOP
  }

#  provisioner "local-exec" {
#    command = "echo \"[jump_service]\n${aws_instance.jump_service.public_ip}\n[jump_service:vars]\nansible_python_interpreter=/usr/bin/python3\" > ../ansible/jump_service.host"
#  }

}
