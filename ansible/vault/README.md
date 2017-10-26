# ansible/vault

Example of use anbile vault.

1. Create file with secret data (eg. passwords): secret.yml
```
echo "secret_password: verySecretPassword123" > secret.yml

cat secret.yml
secret_password: verySecretPassword123
```
2. Encrypt data
```
ansible-vault encrypt secret.yml

cat secret.yml
$ANSIBLE_VAULT;1.1;AES256
62323139306535303331613161366662653533303232383637383836313636386539383139393837
3338343738376135346661353936666234313733313831650a363433383835613566323632366434
34383030636235323964306565656361343465656431636135326532356266386164346236653233
3038303638323230350a346335346133633832663633613133623131353566626433346137613164
66633962336333656330306338643461326562363837346563383265633237643338623430633837
6138623436366662646130306631326665336231646261323231
```

3. Run playbook and provide password in promt
```
ansible-playbook main.yml --ask-vault-pass
Vault password:

```
Or run playbook with password in file
```
echo "pass" > file_with_pass.txt
ansible-playbook main.yml --vault-password-file=file_with_pass.txt
```

In both cases result should be:
```
PLAY [127.0.0.1] ****************************************************************************************************************************************************************************************************************************

TASK [debug] ********************************************************************************************************************************************************************************************************************************
ok: [127.0.0.1] => {
    "secret_password": "verySecretPassword123"
}

PLAY RECAP **********************************************************************************************************************************************************************************************************************************
127.0.0.1                  : ok=1    changed=0    unreachable=0    failed=0
```

## Runned on configuration:
```
ansible 2.4.0.0
python version = 2.7.12 (default, Nov 19 2016, 06:48:10) [GCC 5.4.0 20160609]
```