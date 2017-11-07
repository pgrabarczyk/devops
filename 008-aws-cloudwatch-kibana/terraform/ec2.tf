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

resource "aws_instance" "service" {
  instance_type = "${var.ec2_instance_type}"
  ami = "${data.aws_ami.ubuntu.id}"
  key_name = "${aws_key_pair.auth.id}"
  vpc_security_group_ids = ["${aws_security_group.service.id}"]
  subnet_id = "${aws_subnet.public.id}"
  iam_instance_profile = "${aws_iam_instance_profile.service.id}"

  tags {
    Name = "${var.appname}-service"
  }

  # Generate all.host for ansible
  provisioner "local-exec" {
    command = <<EOP
cat > ../ansible/all.host <<'EOF'
[service]
${aws_instance.service.public_ip}
[service:vars]
ansible_python_interpreter=/usr/bin/python3
EOF
EOP
  }

  # Generate aws_ec2_wait.sh for wait to initialize this instance
  provisioner "local-exec" {
    command = <<EOP
cat > ../ansible/script/aws_ec2_wait.sh <<'EOF'
aws ec2 wait instance-status-ok  \
	--profile ${var.aws_profile} \
	--region ${var.aws_region}  \
	--instance-ids ${aws_instance.service.id}
EOF
EOP
  }

  #Execute ansible playbook
  provisioner "local-exec" {
    command = "sleep 20 && cd ../ansible/ && export ANSIBLE_HOST_KEY_CHECKING=False && ansible-playbook -i all.host all.yml > ansible.log"
  }

}
