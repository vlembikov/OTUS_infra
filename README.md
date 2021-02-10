# OTUS_infra
Конфигурация bastionhost сети:

bastionhost = 34.78.108.124
someinternalhost = 10.132.0.13

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
