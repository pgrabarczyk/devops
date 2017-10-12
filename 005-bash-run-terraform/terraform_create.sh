#!/bin/bash
TAG_NAME='pgrabarczyk'
TERRAFORM_VARS="-var tag_name=$TAG_NAME --var-file=vars.tfvars"

set +e
#set -x

terraform init
if [[ $? -ne 0 ]]; then
  exit 1
fi

# Tertraform plan exit codes:
# 0 = Succeeded with empty diff (no changes)
# 1 = Error
# 2 = Succeeded with non-empty diff (changes present)

terraform plan -out=plan.out $TERRAFORM_VARS -detailed-exitcode
if [ $? -eq 2 ]; then ##Changes found
  terraform apply plan.out
  if [[ $? -ne 0 ]]; then
    exit 1
  fi
fi

exit 0
