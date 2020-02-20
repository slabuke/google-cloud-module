# Revise vars.tf for vars

data "google_compute_zones" "available" {}

resource "google_compute_instance" "bastion-srv" {
  name = "bastion-${var.Name}"  
  description = "Nginx sample VM"
  deletion_protection = false
  project = "${var.Project}"
  zone = "${var.ZoneBastion}"
  machine_type = "${var.Type}"
  tags  =  "${var.TagsBastion}"

  boot_disk {
    initialize_params {
      image = "${var.DiskImage}"
      type = "${var.DiskType}"
      size = "${var.DiskSize}"
    }
  }

  metadata_startup_script = "${var.ProvisionBastion}"

  labels {
    servertype = "${var.LabelSTB}"
    wayofinstallation = "${var.LabelWay}"
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