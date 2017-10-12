#!/bin/bash
TAG_NAME='pgrabarczyk'
TERRAFORM_VARS="-var tag_name=$TAG_NAME --var-file=vars.tfvars"

set -e
terraform destroy --force $TERRAFORM_VARS
