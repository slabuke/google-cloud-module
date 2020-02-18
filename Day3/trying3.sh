#!/bin/bash


# Setip the environment
gcloud compute networks create nw102 --subnet-mode=custom
gcloud compute networks subnets create nw102-us --network nw102 --range 192.168.10.0/24 --region us-central1
gcloud compute networks subnets create nw102-eu --network nw102 --range 192.168.20.0/24 --region europe-west1
gcloud compute firewall-rules create nw102-allow-internal --network nw102 --source-ranges 192.168.10.0/24,192.168.20.0/24 --allow tcp,udp,icmp

# Create VMs in several regions

# Reserving static IP
gcloud compute addresses create nat-gw-us-ip --region us-central1
gcloud compute addresses create nat-gw-eu-ip --region europe-west1

#Create Nat gateways
gcloud compute instances create nat-gw-us --network nw102 --subnet nw102-us --address nat-gw-us-ip --can-ip-forward --zone us-central1-f --image-family debian-9 --image-project debian-cloud
gcloud compute instances create nat-gw-eu --network nw102 --subnet nw102-eu --address nat-gw-eu-ip --can-ip-forward --zone europe-west1-c --image-family centos-7 --image-project centos-cloud

# Create node instances
gcloud compute instances create nat-node-us --network nw102 --subnet nw102-us --zone us-central1-f --image-family debian-9 --image-project debian-cloud
gcloud compute instances create nat-gw-eu --network nw102 --subnet nw102-eu --address nat-gw-eu-ip --can-ip-forward --zone europe-west1-c --image-family centos-7 --image-project centos-cloud

# SSH to each instance
gcloud compute firewall-rules create nw102-allow-ssh --network nw102 --source-ranges 0.0.0.0/0 --allow tcp:22

gcloud compute ssh nat-gw-us --zone us-central1-f

gcloud compute ssh nat-gw-eu --zone europe-west1-c

gcloud compute ssh nat-node-us --zone us-central1-f

gcloud compute ssh nat-node-eu --zone europe-west1-c