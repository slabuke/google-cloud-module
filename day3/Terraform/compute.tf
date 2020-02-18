# Revise variables.tf for vars

data "google_compute_zones" "available" {}

resource "google_compute_instance" "nginx-cw" {
  name = "${var.Name}"  
	description = "Nginx sample VM"
  deletion_protection = true
  project = "${var.Project}"
  zone = "${var.Zone}"
  machine_type = "${var.Type}"
  tags  =  "${var.Tags}"

  boot_disk {
    initialize_params {
      image = "${var.DiskImage}"
      type = "${var.DiskType}"
      size = "${var.DiskSize}"
    }
  }

  metadata_startup_script = "${var.Provision}"

  labels {
    servertype = "${var.LabelST}"
    osfamily = "${var.LabelOF}"
    wayofinstallation = "${var.LabelWay}"
	}

  network_interface {
    network = "${var.student_name}-vpc"
    subnetwork = "sub-${var.student_name}-public"
    access_config = {}
  }

	lifecycle { prevent_destroy = true }

}