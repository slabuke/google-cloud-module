//instance
resource "google_compute_instance" "default" {  
  name         = "day3instance"
  machine_type = "n1-standard-1"
  zone         = "us-central1-a"

  tags = ["http-server", "ssh"]

  boot_disk {
    initialize_params {
      image = "${var.image}"
      size = "${var.disk-size}"
      type = "${var.disk-type}"
    }
  }

  network_interface {
    subnetwork = "${google_compute_subnetwork.subnetpub.name}"
    access_config {}    
  }

  labels = {
    server_type = "${var.labels.[0]}"
    os_family = "${var.labels.[1]}"
    way_of_installation = "${var.labels.[2]}"
  }

  metadata_startup_script = "${var.doscript}"

}