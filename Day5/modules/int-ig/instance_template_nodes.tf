resource "google_compute_instance_template" "db-node" {
  name        = "db-node"
  

  tags = ["int"]

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
	subnetwork = "privatesubnetwork"
  }

metadata_startup_script = "#!/bin/bash \nyum update -y \nyum install epel-release -y \nyum install nginx -y \nsystemctl start nginx \nsystemctl enable nginx\nsudo bash -c \"echo \"$HOSTNAME\" > /usr/share/nginx/html/index.html\""

}

data "google_compute_image" "db" {
  family  = "centos-7"
  project = "centos-cloud"
}

