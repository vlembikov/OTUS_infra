# OTUS_infra
Конфигурация bastionhost сети:

bastion_IP = 34.78.108.124
someinternalhost_IP = 10.132.0.13

webUI for pritunl: https://ovpn.skdata.ru/

Для подключения к someinternalhost через bastionhost можем воспользоваться командой:
````
ssh -t -i ~/.ssh/ll_rsa -A vlembikov@34.78.108.124 ssh 10.132.0.13
````
Создаем файл: in ~/.ssh/config и вставляем в него:
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

testapp_IP = 35.233.51.244
testapp_port = 9292
