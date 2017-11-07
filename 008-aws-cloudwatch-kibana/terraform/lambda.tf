resource "aws_iam_role" "lambda_elasticsearch_execution_role" {
  name = "${var.es_log_role_name}"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "lambda_elasticsearch_execution_policy" {
  name = "${var.es_log_policy_name}"
  role = "${aws_iam_role.lambda_elasticsearch_execution_role.id}"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": [
        "arn:aws:logs:*:*:*"
      ]
    },
    {
      "Effect": "Allow",
      "Action": "es:ESHttpPost",
      "Resource": "arn:aws:es:*:*:*"
    }
  ]
}
EOF
}

resource "aws_lambda_function" "cwl_stream_lambda" {
  filename         = "cwl2eslambda.zip"
  function_name    = "${var.lambda_name}"
  role             = "${aws_iam_role.lambda_elasticsearch_execution_role.arn}"
  handler          = "cwl2es.handler"
  source_code_hash = "${base64sha256(file("cwl2eslambda.zip"))}"
  runtime          = "nodejs4.3"

  environment {
    variables = {
      es_endpoint = "${aws_elasticsearch_domain.es.endpoint}"
    }
  }
}

resource "aws_lambda_permission" "cloudwatch_allow" {
  statement_id = "cloudwatch_allow"
  action = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.cwl_stream_lambda.arn}"
  principal = "${var.lambda_permission_principal}"
  source_arn = "${aws_cloudwatch_log_group.service.arn}"
}

resource "aws_cloudwatch_log_subscription_filter" "cloudwatch_logs_to_es" {
  depends_on = ["aws_lambda_permission.cloudwatch_allow"]
  name            = "cloudwatch_logs_to_elasticsearch"
  log_group_name  = "${aws_cloudwatch_log_group.service.name}"
  filter_pattern  = ""
  destination_arn = "${aws_lambda_function.cwl_stream_lambda.arn}"
}