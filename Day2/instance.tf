provider "google" {
  credentials = "${file("~/gcp/.terraform-admin.json")}"
  project     = "${var.project}"
  region      = "${var.region}"
  zone        = "${var.region}"
}

resource "google_compute_instance" "nginx-gcp-terraform" {
  name                = "${var.name}"
  zone                = "${var.zone}"
  machine_type        = "${var.type}"
  deletion_protection = "${var.deletion}"

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

tags = "${var.tags}"

labels {
  servertype        = "nginx-gcloudserver"
  osfamily          = "redhat"
  wayofinstallation = "gcloud"
}

metadata_startup_script = "sudo yum update -y; sudo yum install -y nginx; sudo systemctl start nginx; sudo systemctl enable nginx"

}

resource "google_compute_disk" "nginx-disk" {
  name                      = "nginx-disk"
  size                      = 10
  type                      = "pd-standard"
  zone                      = "${var.zone}"
}

resource "google_compute_attached_disk" "default" {
  disk     = "${google_compute_disk.nginx-disk.self_link}"
  instance = "${google_compute_instance.nginx-gcp-terraform.self_link}"
}