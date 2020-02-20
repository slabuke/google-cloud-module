resource "google_compute_instance_template" "site" {
  name        = "site"
  

  tags = ["web"]

  labels = {
    environment = "dev"
  }

  machine_type         = "n1-standard-1"
  can_ip_forward       = true

  // Create a new boot disk from an image
  disk {
    source_image = "centos-cloud/centos-7"
    auto_delete  = true
    boot         = true
  }

  network_interface {
    network = "day4-network"
	subnetwork = "publicsubnetwork"
	
  }

metadata_startup_script = "#!/bin/bash \nyum update -y \nyum install epel-release -y \nyum install nginx -y \nsystemctl start nginx \nsystemctl enable nginx"

}

data "google_compute_image" "my_image" {
  family  = "centos-7"
  project = "centos-cloud"
}

