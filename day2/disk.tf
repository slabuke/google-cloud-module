resource "google_compute_disk" "nginx-terraform" {
  	name   = "nginx-terraform-disk"
	type   = "pd-standard"
  	zone   = "us-central1-c"
  	size   = 200

  physical_block_size_bytes = 4096
}

resource "google_compute_attached_disk" "default" {
  disk     = "${google_compute_disk.nginx-terraform.self_link}"
  instance = "${google_compute_instance.vm_instance.self_link}"
}
