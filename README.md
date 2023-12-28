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


HW4
testapp_IP = 158.160.118.171
testapp_port = 9292

Для автоматического создания и конфигурирования ВМ в Яндекс облаке необходимо запустить скрипт create_vm.sh

HW5
- создана ветка packer-base
- файлы перемещены согласно заданию
- установлен packer
- создан сервисный аккаунт в Яндекс облаке
- Создан Packer шаблон для создания fry образа ВМ
- Образ протестирован (решена проблема назначения внешнего ip адреса на ВМ, на которой создается образ; решена проблема преждевременного запуска apt при создании образа)
- Packer шаблон параметризирован
- Создан Packer шаблон для создания bake образа ВМ, создан systemd unit для запуска приложения
- Bake образ протестирован
- Создан скрипт для автоматического создания ВМ на основе bake образа
