provider "google" {
  credentials = "${file("terraform-admin.json")}"
  project     = "${var.project}"
  region      = "${var.region_zone[0]}"
}

resource "google_compute_instance" "default" {
  count        = "${var.instance_count}"
  name         = "${lookup(var.instance_names, count.index)}"
  machine_type = "g1-small"
  zone         = "${var.region_zone[0]}"

  tags = ["${var.tag[0]}", "${var.tag[1]}"]

  boot_disk {
    initialize_params {
      image = "${var.image}"
      size = "${var.size_disk[0]}"
      type = "${var.type_disk[0]}"
    }
  }

  deletion_protection = true

  labels {
    servertype = "${var.label[0]}"
    osfamily= "${var.label[1]}"
    wayofinstallation= "${var.label[2]}"
  }

  network_interface {
    network = "${var.type_network}"
    access_config {
      // Ephemeral IP
    }
  }

  timeouts {
    delete = "40m"
  }
  metadata_startup_script = "${var.sscript}"
}

