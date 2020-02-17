#!/bin/bash

gcloud compute instances create nginx-gcloud \
	--zone=us-central1-c \
	--deletion-protection \
	--custom-cpu=1 \
	--custom-memory=4608MB \
	--boot-disk-type=pd-ssd \
	--boot-disk-size=20GB \
	--image-project=centos-cloud \
	--image-family=centos-7 \
	--labels=servertype=nginx-gcloudserver,osfamily=redhat,wayofinstallation=gcloud \
	--tags=http-server,https-server \
	--metadata startup-script='sudo yum update -y; sudo yum install nginx -y; sudo systemctl start nginx; sudo systemctl enable nginx'

gcloud compute disks create mydisk --size=20GB \
  --zone us-central1-c --type=pd-standard 

gcloud compute instances attach-disk nginx-gcloud \
  --disk mydisk --zone us-central1-c

# gcloud compute instances start --zone us-central1-c nginx-gcloud
# gcloud compute ssh --zone us-central1-c 	 nginx-gcloud
# sudo yum update -y
# sudo yum install nginx -y
# sudo systemctl start nginx


# gcloud compute instances stop --zone us-central1-c nginx-gcloud nginx-gcp-ui
# gcloud compute instances start --zone us-central1-c nginx-gcloud nginx-gcp-ui
