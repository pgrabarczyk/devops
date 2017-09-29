output "id" {
  value = "${aws_vpc.vpc.id}"
}
output "subnet_public_id" {
  value = "${aws_subnet.public.id}"
}
