//res
resource "google_compute_instance" "default" {  
  count         = "${var.instance_count}"
  name         = "${lookup(var.instance_names, count.index)}"
  machine_type = "g1-small"
  zone         = "us-central1-a"

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

   timeouts {
    delete = "40m"
  }

}