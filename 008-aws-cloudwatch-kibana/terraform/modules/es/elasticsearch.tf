resource "aws_elasticsearch_domain" "es" {
  domain_name = "${var.appname}"
  elasticsearch_version = "5.5"

  cluster_config {
    instance_type = "t2.small.elasticsearch"
    instance_count = 1
  }

  ebs_options {
    ebs_enabled = true
    volume_size = "10"
  }

  tags {
    Name = "${var.appname}-es"
  }

  access_policies = "${data.template_file.iam-role-elasticsearch.rendered}"

}
