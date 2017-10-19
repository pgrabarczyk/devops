resource "aws_cloudwatch_log_group" "service" {
  name = "${var.log_group_name}"

  tags {
    Name = "${var.appname}_lg_service"
  }
}

resource "aws_cloudwatch_log_stream" "service" {
  name = "${var.log_stream_name}"
  log_group_name = "${aws_cloudwatch_log_group.service.name}"
}
