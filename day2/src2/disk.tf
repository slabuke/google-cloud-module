resource "google_compute_disk" "nginxdisk" {
  name  = "nginxdisk"
  type  = "pd-standard"
  zone  = "us-central1-c"
  size = "10"
}

resource "google_compute_attached_disk" "default" {
   disk     = "${google_compute_disk.nginxdisk.self_link}"
   instance = "${google_compute_instance.vm_instance.self_link}"
#   zone = "us-central1-c"
}
