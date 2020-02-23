# Revise vars.tf for vars

data "google_compute_zones" "available" {}

resource "google_compute_instance" "bastion-srv" {
  name = "${var.name}"  
  description = "Bastion VM"
  deletion_protection = false
  project = "${var.project}"
  zone = "${var.zone}"
  machine_type = "${var.type}"
  tags  =  "${var.tags}"

  boot_disk {
    initialize_params {
      image = "${var.dimage}"
      type = "${var.dtype}"
      size = "${var.dsize}"
    }
  }

  metadata_startup_script = "${var.script}"

  labels {
    servertype = "${var.label-type}"
    wayofinstallation = "${var.label-way}"
  }

  network_interface {
    network = "${var.vpc-name}"
    subnetwork = "${var.sub-vpc-public-name}"
    access_config = {
    nat_ip = "${var.bastion-ip-address}"
    }
  }

  # lifecycle { prevent_destroy = true }

}