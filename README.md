# centhis_infra
centhis Infra repository

bastion_IP = 158.160.126.29

someinternalhost_IP = 10.128.0.4

Для подключения через Jump Host использовать команду:
```bash
ssh -i ~/.ssh/centhis -J centhis@158.160.126.29 centhis@10.128.0.4
```

Для подключения к внутреннему хосту через SSH алиас необходимо создать файл ~/.ssh/config
```
Host bastion
	Hostname 158.160.126.29
	User centhis
	IdentityFile ~/.ssh/centhis

Host some-internal-host
	Hostname 10.128.0.4
	User centhis
	ProxyJump bastion
```
после этого подключение можно выполнять через 
```bash
ssh some-internal-host
```
