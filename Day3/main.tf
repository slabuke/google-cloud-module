provider "google" {
  credentials = "${file("~/gcp/.terraform-admin.json")}"
  project     = "${var.project}"
  zone        = "${var.zone}"
}


resource "google_compute_instance" "default" {
  name                = "${var.name}"
  zone                = "${var.zone}"
  machine_type        = "${var.type}"
  deletion_protection = "${var.deletion}"
  tags                = "${var.tags}"

  boot_disk {
    initialize_params {
    size  = "${var.disk_size}"
    type  = "${var.disk_type}"
    image = "${var.disk_image}"
    }
  }

  network_interface {
    subnetwork = "${google_compute_subnetwork.subnetpub.name}"
    access_config {}    
  }


labels {
  servertype        = "nginxserver"
  osfamily          = "debian"
  wayofinstallation = "terraform"
}

metadata_startup_script = "${var.nginx_setup}"

}