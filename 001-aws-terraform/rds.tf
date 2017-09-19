resource "aws_db_instance" "rds" {
    allocated_storage = 10
    engine            = "mysql"
    engine_version    = "5.6.27"
    instance_class    = "${var.db_instance_class}"
    name              = "${var.db_name}"
    username          = "${var.db_username}"
    password          = "${var.db_password}"
    db_subnet_group_name = "${aws_db_subnet_group.rds_subnetgroup.name}"
    vpc_security_group_ids = ["${aws_security_group.rds.id}"]
}
