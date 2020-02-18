provider "google" {
  credentials = "${file("vnikiforov-day1-01a8a4fa28c7.json")}"
  project     = "${var.project}"
  region      = "${var.region}"
}


data "google_compute_zones" "available" {}


resource "google_compute_instance" "nginx-cw" {
 	name = "${var.name}"
 	zone = "${var.zone}"
	machine_type = "${var.mt}"
	deletion_protection = "${var.protection}"
network_interface {
    network = "${var.sname}-vpc"
    subnetwork = "sub-${var.sname}-public"
    access_config = {}
  }
 
 
 labels = {
    servertype = "${var.srv}"
    osfamily= "${var.os}"
    wayofinstallation= "${var.way}"
  }
 tags = "${var.tags}"
boot_disk {
  initialize_params {
	type = "${var.disk}"
	image = "${var.image}"
	size = "${var.size}"
   }
 }
lifecycle { prevent_destroy = true }
  metadata_startup_script = "${var.script}"
}


