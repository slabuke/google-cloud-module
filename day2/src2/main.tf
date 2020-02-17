provider "google" {
  credentials = "${file("terraform-admin.json")}"
  project     = "${var.project}"
  region      = "${var.region}"
 }

resource "google_compute_instance" "vm_instance" {
  name         = "${var.vm_name}"
  zone         = "${var.zone}"
  
  boot_disk {
    initialize_params {
      size = "${var.disk_size}"
      type = "${var.disk_type}"
      image = "${var.image}"
    }
  }

  machine_type = "${var.machine_type}"

  metadata_startup_script = "${var.script}"

  deletion_protection = "${var.protection}"

  network_interface {
    network = "${var.network}"
    access_config {}
  }
  
  tags = "${var.tags}"

  labels = {
    servertype = "${var.label_type}"
    osfamily = "${var.label_os}"
    wayofinstallation = "${var.label_way}"
  }

}


