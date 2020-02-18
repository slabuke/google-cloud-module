provider "google" {
  credentials = "${file(".vocal-door-268207-231b2e12386e.json")}"
  project     = "vocal-door-268207"
  region      = "us-central1"
}

resource "google_compute_instance" "nginx-classwork-terraform" {
  count               = "${var.instance_count}"
  name                = "${var.name}-${count.index}"
  machine_type        = "${var.Instance_type}"
  zone                = "${var.Zone}"
  tags                = ["http-server", "https-server"]
  deletion_protection = "true"

  metadata_startup_script = <<EOF
  sudo apt-get -y update
  sudo apt-get -y install nginx
  sudo systemctl start nginx
  sudo systemctl enable nginx
EOF

  boot_disk {
    initialize_params {
      type  = "pd-ssd"
      size  = "${var.SSDsize}"
      image = "${var.Image_source}"
    }
  }

  network_interface {
    network       = "default"
    access_config = {}
  }

  labels = {
    servertype        = "nginxserver"
    osfamily          = "debian"
    wayofinstallation = "terraform"
  }

  timeouts {
    delete = "40m"
  }
}
