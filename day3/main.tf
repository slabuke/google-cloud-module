provider "google" {
  credentials = "${file("terraform-admin.json")}"
  project     = "${var.project}"
}

resource "google_compute_instance" "nginx-terraform" {
  name         = "${var.name[0]}"
  machine_type = "${var.mtype[2]}"
  zone         = "${var.region_zone[0]}"

  tags = ["${var.tag[0]}", "${var.tag[1]}"]

  boot_disk {
    initialize_params {
      image = "${var.image[1]}"
      size = "${var.size_disk[2]}"
      type = "${var.type_disk[0]}"
    }
  }

  deletion_protection = false

  labels {
    servertype = "${var.label[0]}"
    osfamily= "${var.label[2]}"
    wayofinstallation= "${var.label[3]}"
  }

  network_interface {
    network = "${google_compute_network.maxim-vpc.name}"
    subnetwork = "${google_compute_subnetwork.public-sub.name}"
    access_config {
      // Ephemeral IP
    }
  }

  metadata_startup_script = "${var.sscript}"
}




