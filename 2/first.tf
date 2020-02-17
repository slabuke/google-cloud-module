provider "google" {
  credentials = "${file(".vocal-door-268207-231b2e12386e.json")}"
  project     = "vocal-door-268207"
  region      = "us-central1"
}

resource "google_compute_instance" "nginx-terraform" {
  name                = "${var.name}"
  machine_type        = "${var.Instance_type}"
  zone                = "${var.Zone}"
  tags                = ["http-server", "https-server"]
  deletion_protection = "true"

  metadata_startup_script = <<EOF
  sudo yum -y update
  sudo yum -y install nginx
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
    osfamily          = "redhat"
    wayofinstallation = "terraform"
  }
}

resource "google_compute_disk" "nginx-gcp-ter" {
  name   = "nginx-gcp-ter"
  zone   = "${var.Zone}"
  size   = "100"
  labels = {}

  physical_block_size_bytes = 4096
}

resource "google_compute_attached_disk" "default" {
  disk     = "${google_compute_disk.nginx-gcp-ter.self_link}"
  instance = "${google_compute_instance.nginx-terraform.self_link}"
}
