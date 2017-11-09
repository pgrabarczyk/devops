resource "aws_iam_role" "cloudwatch_logs_to_es" {
  name = "${var.es_log_role_name}"

  assume_role_policy = "${data.template_file.iam-role-cw-to-es.rendered}"
}

resource "aws_iam_role_policy" "cloudwatch_logs_to_es" {
  name = "${var.es_log_policy_name}"
  role = "${aws_iam_role.cloudwatch_logs_to_es.id}"
  policy = "${data.template_file.iam-role-policy-cw-to-es.rendered}"
}

resource "aws_lambda_function" "cloudwatch_logs_to_es" {
  filename         = "${var.lambda_filename_zip}"
  function_name    = "${var.lambda_name}"
  role             = "${aws_iam_role.cloudwatch_logs_to_es.arn}"
  handler          = "${var.lambda_function_name}.handler"
  source_code_hash = "${base64sha256(file("${var.lambda_filename_zip}"))}"
  runtime          = "nodejs4.3"

  environment {
    variables = {
      es_endpoint = "${aws_elasticsearch_domain.es.endpoint}"
    }
  }

}

resource "aws_lambda_permission" "cloudwatch_logs_to_es" {
  statement_id = "cloudwatch_logs_to_es"
  action = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.cloudwatch_logs_to_es.arn}"
  principal = "${var.lambda_permission_principal}"
  source_arn = "${var.cloud_watch_log_group_arn}"
}

resource "aws_cloudwatch_log_subscription_filter" "cloudwatch_logs_to_es" {
  depends_on = ["aws_lambda_permission.cloudwatch_logs_to_es"]
  name            = "cloudwatch_logs_to_elasticsearch"
  log_group_name  = "${var.cloud_watch_log_group_name}"
  filter_pattern  = ""
  destination_arn = "${aws_lambda_function.cloudwatch_logs_to_es.arn}"
}