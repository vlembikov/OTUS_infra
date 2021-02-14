#!/bin/bash

#Start instanc
gcloud compute instances create reddit-app\
 --tags puma-server \
 --image-family reddit-full \
 --preemptible \
 --machine-type=e2-micro

#Open firewall port 9292
gcloud compute firewall-rules create default-puma-server\
 --direction=INGRESS \
 --priority=1000 \
 --network=default \
 --action=ALLOW \
 --rules=tcp:9292 \
 --source-ranges=0.0.0.0/0 \
 --target-tags=puma-server
