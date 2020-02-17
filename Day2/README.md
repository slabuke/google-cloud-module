# Google-cloud-module
## Task02 by Vitali Andrushkevich

I created three different instance using different ways: google cloud gui, gcloud console (used api) and terraform.

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
  
  >Terraform create (with attached disk using terraform)


```tf
//instance.tf
provider "google" {
  credentials = "${file("~/gcp/.terraform-admin.json")}"
  project     = "${var.project}"
  region      = "${var.region}"
  zone        = "${var.region}"
}

resource "google_compute_instance" "nginx-gcp-terraform" {
  name                = "${var.name}"
  zone                = "${var.zone}"
  machine_type        = "${var.type}"
  deletion_protection = "${var.deletion}"

  boot_disk {
    initialize_params {
    size  = "${var.disk_size}"
    type  = "${var.disk_type}"
    image = "${var.disk_image}"
    }
  }

  network_interface {
    network       = "default"
    subnetwork    = "default"
    access_config = {}
  }

tags = "${var.tags}"

labels {
  servertype        = "nginx-gcloudserver"
  osfamily          = "redhat"
  wayofinstallation = "gcloud"
}

metadata_startup_script = "sudo yum update -y; sudo yum install -y nginx; sudo systemctl start nginx; sudo systemctl enable nginx"

}

resource "google_compute_disk" "nginx-disk" {
  name                      = "nginx-disk"
  size                      = 10
  type                      = "pd-standard"
  zone                      = "${var.zone}"
}

resource "google_compute_attached_disk" "default" {
  disk     = "${google_compute_disk.nginx-disk.self_link}"
  instance = "${google_compute_instance.nginx-gcp-terraform.self_link}"
}
```
![Image alt](https://github.com/MNT-Lab/google-cloud-module/blob/vandrushkevich/Day2/img/ldODWYiecn.png)

Also you can watch all screenshots [here][1]

And watch scripsts [gcloud_create.sh][2] [instance.tf][3] [variables.tf][4]

[1]: https://github.com/MNT-Lab/google-cloud-module/tree/vandrushkevich/Day2/img
[2]: https://github.com/MNT-Lab/google-cloud-module/blob/vandrushkevich/Day2/gcloud_create.sh
[3]: https://github.com/MNT-Lab/google-cloud-module/blob/vandrushkevich/Day2/instance.tf
[4]: https://github.com/MNT-Lab/google-cloud-module/blob/vandrushkevich/Day2/variables.tf
