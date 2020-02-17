resource "google_compute_disk" "nginx-attached-disk" {
  name = "nginx-attached"
  type = "${var.attdisk[0]}"
  zone = "${var.attdisk[1]}"
  size = "${var.attdisk[2]}"
  physical_block_size_bytes = 4096
}

resource "google_compute_attached_disk" "default" {
  disk = "${google_compute_disk.nginx-attached-disk.self_link}"
  instance = "${google_compute_instance.default.self_link}"
}