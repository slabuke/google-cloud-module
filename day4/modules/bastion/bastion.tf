variable "network"{}
variable "publicsub"{}

resource "google_compute_instance" "bastion" {
  name         = "${var.name[1]}"
  machine_type = "${var.mtype[2]}"
  zone         = "${var.region_zone[2]}"

  tags = ["ssh"]

  boot_disk {
    initialize_params {
      image = "${var.image[1]}"
      size = "${var.size_disk[1]}"
      type = "${var.type_disk[0]}"
    }
  }

  deletion_protection = false

  labels {
    servertype = "${var.label[4]}"
    osfamily= "${var.label[2]}"
    wayofinstallation= "${var.label[3]}"
  }

  network_interface {
    network = "${var.network}"
    subnetwork = "${var.publicsub}"
    access_config {
      // Ephemeral IP
    }
  }
}

