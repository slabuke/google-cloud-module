resource "google_compute_instance" "default" {
  name         = "nginx-terraform"
  machine_type = "custom-1-4608"
  zone         = "us-central1-c"

  tags = ["http-server", "https-server"]

  deletion_protection = "true"

  boot_disk {
    initialize_params {
      image = "${var.image}"
      size = "${var.disk-size}"
      type = "${var.disk-type}"
    }
  }

  network_interface {
    network = "default"
    access_config {}    
  }

  labels = {
    server_type = "${var.labels.[0]}"
    os_family = "${var.labels.[1]}"
    way_of_installation = "${var.labels.[2]}"
  }

  metadata_startup_script = "${var.doscript}"

}