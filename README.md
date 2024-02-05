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


HW6
- создана ветка terraform-1
- установлен terraform
- установлен провайдер для подключения terraform к yandex cloud и настроено подключение
- из образа, созданного в предыдущем задании с помощью terraform развернута ВМ
- решена проблема с подключением к созданной ВМ по SSH
- созданы output variables
- для финальной настройки ВМ добавлены провижинеры
- проверена работа приложения
- добавлены входные переменные
- добавлено создание балансировщика нагрузки
- добавлено создание вторго инстанса приложения. Такой вариант может привести к трудностям поддержания консистентности конфигурации при модифицировании инфраструктуры.
- реализован подход к созданию необходимого количества инстансов через параметр count. Не решена проблема с автоматическим добовлением созданных через параметров count инстансов в целевую группу(в данной реализации каждый инстанс прописывается в коде). Переменная count параметризованна.

HW7
- создана ветка terraform-2
- в переменной count установлено значение 1, lb.tf перемещен в папку files
- протестировано создание подсети с помощью terraform
- протестированы неявные зависимости в terraform
- при помощи packer созданы 2 новых базовых образа: сервер БД и сервер приложений
- создание сервера БД и сервера приложения вынесено в отдельные конфигурационные файлы
- созданы модули app и db
- работа модулей протестированна.
- созданы 2 сценария развертывания: stage и prod
- создано дополнительный параметр конфигурации определяющий имя ВМ. параметр устанавливается в зависимости от сценария
- конфигурационные файлы отформатированны командой terraform fmt -recursive
- для сценариев stage и prod настроено сохранение состояния в удаленный backend на базе Yandex Object Storrage
- для сценариев stage и prod настроена блокировка изменения состояния во время применения конфигурации
- решение протестировано путем попытки одновременного запуска применения конфигурации из разных папок
- реализованы провижионеры, необходимые для установки ПО, изменения конфигурационных файлов и запуска приложения.

HW8
- Установка Ansible не потребовалась, т.к. установленный Ansible подошел под требования к версии
- развернуто окружение stage из настроенного в прошлом домашнем задании terraform
- настроен статический inventory
- выполнено и протестированно подключение через ansible. протестированно управление хостами через ansible с помошью команд.
- выполнено конфигурация ansible с помощью конфигурационного файла
- протестированна работа с группами хостов
- создан статический inventory в формате yaml
- протестированна работа различных команд.
- создан playbook
- для динамического inventory написан bash скрипт, который получает output переменные из состояния terraform и возвращает их, согласно документации ansible, в формате json
- в конфигурации ansible прописан созданный скрипт для получения динамического inventory.
- так же есть возможность получения данных непосредственно из Яндекс Облака, но в данной конфигурации не создаются теги для ВМ и в дальнейшем сложно будет разделять окружения.

HW9
- создана ветка ansible-2
- создан плейбук одним сценарием reddit_app.yml
- созданы шаблоны конфигурационных файлов
- выполнение сценария протестированно
- созданы хэндлеры
- работа хэндлеров протестированна
- создан плейбук с несколькими сценариями
- работа плейбука протестированна
- сценариии разнесены по разным плейбукам
- работа с несколькими плейбуками протетсированна
- задание со * недоступно для выполнения
- созданы сценарии для нустановки ПО в packer
- протестированна интергация packer и ansible. дополнительно решена проблема интеграции на ubuntu 22.04 (устаревший формат ssh ключей у packer)

HW10
- создана ветка ansible-3
- созданы структуры ролей app и db при помощи команды ansible-galaxy init
- плейбуки app и db перенесены в соответсвующие роли
- работа ролей успешно протестирована
- созданы различные настройки окружений для различных окружений
- окружением по умолчанию задано окружение stage
- для окружений заданы групповые переменные
- добавлен вывод текущего окружения в вывод ansible
- файлы, созданные в предыдущих ДЗ перенесены в соответствующие папки
- проверено выполнение плейбуков с использованием ролей на окружениях stage и prod
- установлена коммюнити роль jdauphant.nginx
- папка с установленной ролью добавлена в .gitignore
- роль настроена и протестирована в окружении stage
- подготовлен плейбук для создания пользователей с использованием ansible vault
- подготовлены файлы с данными пользователей в окружениях stage и prod
- файлы зашифрованы с использованием vault.key
- проверено создание пользователей с помощью ранее созданых плейбуков
- динамический инвентори для окружений stage и prod настроен
