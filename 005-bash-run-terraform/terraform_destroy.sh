#!/bin/bash
TAG_NAME='pgrabarczyk'
VAR_FILE='vars.tfvars'
TERRAFORM_VARS="-var tag_name=$TAG_NAME --var-file=$VAR_FILE"

set -e
terraform destroy --force $TERRAFORM_VARS
