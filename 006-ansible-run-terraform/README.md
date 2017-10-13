# 006-ansible-run-terraform

Idea is to execute terraform script via ansible.

## Variables to edit
terraform_execute_dir in:
- terraform_create.yml
- terraform_destroy.yml

terraform/vars.tfvars - credientials to your terraform

## Execute

```
ansible-playbook terraform_create.yml -i local.host -vvv
ansible-playbook terraform_destroy.yml -i local.host -vvv
```

## Runned on configuration:
```
Terraform v0.10.7
ansible 2.4.0.0
python version = 2.7.12 (default, Nov 19 2016, 06:48:10) [GCC 5.4.0 20160609]
```
