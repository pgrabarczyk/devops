data "template_file" "iam-role-elasticsearch" {
  template = "${file("${path.module}/policies/elasticsearch.json")}"

  vars {
    allowed_cidrs = "${var.devCIDR}"
  }
}

data "template_file" "iam-role-cw-to-es" {
  template = "${file("${path.module}/policies/cloudwatch_logs_to_es_iam_role.json")}"
}

data "template_file" "iam-role-policy-cw-to-es" {
  template = "${file("${path.module}/policies/cloudwatch_logs_to_es_iam_role_policy.json")}"
}