provider "google" {
  credentials = "${file("my-first123-project-b51f6dad3b4d.json")}"
  project     = "${var.project_name}"
  region      = "${var.region}"
}

  resource "google_compute_instance" "nginx-terraform" {
  count="${var.instances}"
  name="${var.name}-${count.index}" 
  project = "${var.project_name}"
  machine_type = "custom-1-1792"
  zone         = "${var.zones}"
  tags = "${var.tags}"

  boot_disk {
    initialize_params {
      image = "ubuntu-1604-lts"
      size = "${var.size}"
  	  type = "pd-ssd"
  	}
  	
  }

  labels = {
    servertype = "nginxserver"
    osfamily = "debian"
    wayofinstalation = "terraform"
  }

  network_interface {
    network = "default"
    access_config {}
  }
  deletion_protection = true
  metadata_startup_script = "sudo yum install nginx -y"
  count = 2
}

