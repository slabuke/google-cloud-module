provider "google" {
  credentials = "${file("~/gcp/.terraform-admin.json")}"
  project     = "${var.project}"
  region      = "${var.region}"
  zone        = "${var.region}"
}

resource "google_compute_instance" "nginx-classwork-terraform" {
  count               = "${var.instances}"
  name                = "${var.name}-${count.index}"
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
    network       = "default"
    subnetwork    = "default"
    access_config = {}
  }

labels {
  servertype        = "nginxserver"
  osfamily          = "debian"
  wayofinstallation = "terraform"
}

metadata_startup_script = "sudo apt-get -y update; sudo apt-get -y install nginx; sudo systemctl start nginx; sudo systemctl enable nginx"

}