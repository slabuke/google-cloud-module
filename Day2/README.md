# Google-cloud-module
## Task02 by Vitali Andrushkevich

I created three different instance using different opportunities. firstly, google cloud gui, gcloud console (used api) and terraform

![Image alt](https://github.com/MNT-Lab/google-cloud-module/blob/vandrushkevich/Day2/img/common%20list.png)

>Google cloud GUI (with attached disk via gui)

![Image alt](https://github.com/MNT-Lab/google-cloud-module/blob/vandrushkevich/Day2/img/gui-1.png)
![Image alt](https://github.com/MNT-Lab/google-cloud-module/blob/vandrushkevich/Day2/img/gui-2.png)

>Google cloud API (with attached disk via console)

```bash
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
  ```
