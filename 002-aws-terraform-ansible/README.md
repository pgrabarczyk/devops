//TODO

## Execute:
```
cd terraform
terraform plan -var-file=002.tfvars
terraform apply -var-file=002.tfvars
```

Then aws env should be mostly ready.

Now you should be able to execute ansible script:
```
cd ../ansible
ansible-playbook -i all.host playbook.yml -vvv
```

You can ssh to your backend_services using:
```
ssh -i PATH_TO_KEY -o ProxyCommand="ssh -W %h:%p -q ubuntu@JUMP_SERVICE_PUBLIC_IP" ubuntu@BACKEND_SERVICE_PRIVATE_IP
```

### Clean up (Destroy AWS environment)
```
cd ../terraform
terraform destroy -var-file=002.tfvars
```

## Runned on configuration:
```
Terraform v0.10.2
ansible 2.4.0.0
python version = 2.7.12 (default, Nov 19 2016, 06:48:10) [GCC 5.4.0 20160609]
```
