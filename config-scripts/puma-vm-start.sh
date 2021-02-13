#!/bin/bash

#Start instanc
gcloud compute instances create reddit-app\
 --boot-disk-size=10GB \
 --image-family ubuntu-1604-lts \
 --image-project=ubuntu-os-cloud \
 --machine-type=e2-micro \
 --tags puma-server \
 --restart-on-failure \
 --preemptible \
 --metadata-from-file startup-script=./startup-script.sh

#Open firewall port 9292
gcloud compute firewall-rules create default-puma-server\
 --direction=INGRESS \
 --priority=1000 \
 --network=default \
 --action=ALLOW \
 --rules=tcp:9292 \
 --source-ranges=0.0.0.0/0 \
 --target-tags=puma-server
