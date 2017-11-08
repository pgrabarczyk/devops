module "vpc" {
  source = "modules/vpc"
  appname = "${var.appname}"
  aws_region = "${var.aws_region}"
}
module "ec2" {
  source = "modules/ec2"
  appname = "${var.appname}"

  aws_region = "${var.aws_region}"
  aws_profile = "${var.aws_profile}"

  ec2_instance_type = "${var.ec2_instance_type}"
  subnet_id = "${module.vpc.subnet_id}"

  ec2_log_role_name = "${var.ec2_log_role_name}"
  ec2_log_policy_name = "${var.ec2_log_policy_name}"

  vpc_id = "${module.vpc.vpc_id}"
  devCIDR = "${var.devCIDR}"

  key_name = "${var.key_name}"
  public_key_path= "${var.public_key_path}"

  log_group_name = "${var.log_group_name}"
  log_stream_name = "${var.log_stream_name}"
}
module "es" {
  source = "modules/es"
  appname = "${var.appname}"
  devCIDR = "${var.devCIDR}"

  cloud_watch_log_group_arn = "${module.ec2.cloud_watch_log_group_arn}"
  cloud_watch_log_group_name = "${var.log_group_name}"

  lambda_name = "${var.lambda_name}"
  lambda_permission_principal = "${var.lambda_permission_principal}"
  lambda_filename_zip = "${var.lambda_filename_zip}"
  lambda_function_name = "${var.lambda_function_name}"

  es_log_role_name = "${var.es_log_role_name}"
  es_log_policy_name = "${var.es_log_policy_name}"

}