provider "google" {
  credentials = "${file("vnikiforov-day1-01a8a4fa28c7.json")}"
  project     = "${var.project}"
  region      = "${var.region}"
}
resource "google_compute_address" "static" {
  name = "${var.ipv4}"
}
resource "google_compute_instance" "nginx-terraform" {
 name         = "${var.name}"
 zone         = "${var.zone}"
 network_interface {
    network = "${var.network}"
    access_config {
    }
 }
 machine_type = "${var.mt}"
 deletion_protection = "${var.protection}"
 labels = {
    servertype = "${var.srv}"
    osfamily= "${var.os}"
    wayofinstallation= "${var.way}"
  }
 tags = ["http-server","https-server"]
 boot_disk {
   initialize_params {
     type = "${var.disk}"
     image = "${var.image}"
     size = "${var.size}"
   }
 }
 lifecycle {
    ignore_changes = ["attached_disk"]
  }
  metadata_startup_script = "${var.script}"
}

resource "google_compute_disk" "my-disk" {
  name  = "${var.gcdname}"
  type  = "${var.gcdtype}"
  zone  = "${var.gcdzone}"
  size = "${var.gcdsize}"
}

resource "google_compute_attached_disk" "nginx-terraform" {
  disk     = "${google_compute_disk.my-disk.self_link}"
  instance = "${google_compute_instance.nginx-terraform.self_link}"
}
output "url" {
  value = "http://${google_compute_instance.nginx-terraform.network_interface.0.access_config.0.nat_ip}"
}
