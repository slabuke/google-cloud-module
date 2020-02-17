provider "google" {
  credentials = "${file("terraform-admin.json")}"
  project     = "${var.project}"
  region      = "${var.region_zone}"
}

resource "google_compute_instance" "default" {
  name         = "${var.name}"
  machine_type = "${var.mtype}"
  zone         = "${var.region_zone}"

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

  metadata_startup_script = "${var.sscript}"
}

resource "google_compute_disk" "nginx-disk-terraform" {
  name = "nginx-disk-terraform"
  type = "${var.type_disk[1]}"
  zone = "${var.region_zone}"
  size = "${var.size_disk[1]}"
  physical_block_size_bytes = 4096
}

resource "google_compute_attached_disk" "default" {
  disk = "${google_compute_disk.nginx-disk-terraform.self_link}"
  instance = "${google_compute_instance.default.self_link}"
}