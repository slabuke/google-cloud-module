resource "google_compute_disk" "nginx-terraform" {
  name  = "${var.attdiskname}"
  type  = "${var.attdisktype}"
  zone  = "${var.zone}"
  size = "${var.attdisksize}"
}

resource "google_compute_attached_disk" "nginx-terraform" {
  disk     = "${google_compute_disk.nginx-terraform.self_link}"
  instance = "${google_compute_instance.nginx-terraform.self_link}"
}
