# OTUS_infra

<details><summary>Выполнено ДЗ № 5 > cloud-bastion</summary><p>

## Конфигурация bastionhost сети:
````
bastion_IP = 34.78.108.124
someinternalhost_IP = 10.132.0.13
````
## Как проверить работоспособность:
 - Перейти по ссылке http://35.233.51.244:9292
 
## Для подключения к someinternalhost через bastionhost можем воспользоваться командой:
````
ssh -t -i ~/.ssh/ll_rsa -A vlembikov@34.78.108.124 ssh 10.132.0.13
````
## Создаем файл: in ~/.ssh/config и вставляем в него:
````
Host bastionhost
User vlembikov
HostName 34.78.108.124
ForwardAgent yes
IdentityFile ~/.ssh/ll_rsa

Host someinternalhost
User vlembikov
HostName 10.132.0.13
ProxyJump bastionhost
ForwardAgent yes
IdentityFile ~/.ssh/ll_rsa
````
</p></details>

<details><summary>Выполнено ДЗ № 6 > cloud-testapp</summary><p>
  
## Параметры сервера:
````
testapp_IP = 35.233.51.244 
testapp_port = 9292
````
## В процессе сделано:
 - Написан скрипт install_mongodb.sh для установки mongodb
 - Написан скрипт install_ruby.sh для установки ruby
 - Написан скрипт startup-script.sh
 - Написан скрипт puma-vm-start.sh для автоматического разворачивания сервера открытия порта и диплоя приложения через скрипт startup-script.sh

## Как запустить проект:
 - Для запуска проекта достаточно из корня директории запустить скрипт bash puma-vm-start.sh
 - Для поднятия машины с приложением можно выполнить в ручную команду:
 
````
gcloud compute instances create reddit-app\
 --boot-disk-size=10GB \
 --image-family ubuntu-1604-lts \
 --image-project=ubuntu-os-cloud \
 --machine-type=e2-micro \
 --tags puma-server \
 --restart-on-failure \
 --preemptible \
 --metadata-from-file startup-script=./startup-script.sh
````

## Для открытия порта 9292 можно выполнить команду:
````
gcloud compute firewall-rules create default-puma-server\
 --direction=INGRESS \
 --priority=1000 \
 --network=default \
 --action=ALLOW \
 --rules=tcp:9292 \
 --source-ranges=0.0.0.0/0 \
 --target-tags=puma-server
````
## Для удаления машины можно выполнить команду:
````
gcloud compute instances delete reddit-app
````
## Для удаления правила в фаерволе:
````
gcloud compute firewall-rules delete default-puma-server
````
## Как проверить работоспособность:
 - Перейти по ссылке http://35.233.51.244:9292
</p></details>

<details><summary>Выполнено ДЗ № 7 > packer-base</summary><p>

 - [ ] Основное ДЗ
 - [ ] Задание со *

## В процессе сделано:
 - Реализован вынос переменных в файл variables.json.
 - Добавить исключение в файл .gitignore.
 - Реализовать заглушку variables.json.example.
 - Разобраться с подходом Immutable infrastructure.
 - Сделать скрипт запуска create-reddit-vm.sh для запуска готовой машины.

## Как запустить проект:
````
gcloud compute instances create reddit-app\
 --tags puma-server \
 --image-family reddit-full \
 --preemptible \
 --machine-type=e2-micro
````
````
gcloud compute firewall-rules create default-puma-server\
 --direction=INGRESS \
 --priority=1000 \
 --network=default \
 --action=ALLOW \
 --rules=tcp:9292 \
 --source-ranges=0.0.0.0/0 \
 --target-tags=puma-server
````

## Как проверить работоспособность:
 - Например, перейти по ссылке http://34.77.29.108:9292

## PR checklist
 - [ ] Выставил label с номером домашнего задания
 - [ ] Выставил label с темой домашнего задания
 </p></details>
