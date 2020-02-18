resource "google_compute_instance" "nginx-terraform" {
  name         = "${var.name}"
  machine_type = "${var.Instance_type}"
  zone         = "${var.Zone}"
  tags         = ["http-server", "https-server"]

  metadata_startup_script = <<EOF
  sudo -i
  apt-get -y update
  apt-get -y install nginx
  systemctl start nginx
  systemctl enable nginx
  echo 'Hello from Andrei Batura!' > /var/www/html/index.html
EOF

  boot_disk {
    initialize_params {
      type  = "pd-ssd"
      size  = "${var.SSDsize}"
      image = "${var.Image_source}"
    }
  }

  network_interface {
    network       = "${var.network_name}"
    subnetwork    = "${var.Subnet-1-name}"
    access_config = {}
  }

  labels = {
    servertype        = "nginxserver"
    osfamily          = "debian"
    wayofinstallation = "terraform"
  }
}

provider "google" {
  credentials = "${file(".vocal-door-268207-231b2e12386e.json")}"
  project     = "vocal-door-268207"
  region      = "us-central1"
}

resource "google_compute_network" "andrei-vpc" {
  name                    = "${var.network_name}"
  description             = "Main VPC network"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "Subnet-1" {
  name          = "${var.Subnet-1-name}"
  region        = "${var.network-region}"
  network       = "${google_compute_network.andrei-vpc.self_link}"
  description   = "Public range"
  ip_cidr_range = "${var.Subnet-1-ip_cidr_range}"
}

resource "google_compute_subnetwork" "Subnet-2" {
  name          = "${var.Subnet-2-name}"
  region        = "${var.network-region}"
  network       = "${google_compute_network.andrei-vpc.self_link}"
  description   = "Private range"
  ip_cidr_range = "${var.Subnet-2-ip_cidr_range}"
}

resource "google_compute_firewall" "firewall-private" {
  name        = "${var.Subnet-2-name}"
  network     = "${var.network_name}"
  description = "Private Firewall rules"

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }

  source_ranges = ["${var.Subnet-2-ip_cidr_range}"]
}

resource "google_compute_firewall" "firewall-public" {
  name        = "${var.Subnet-1-name}"
  network     = "${var.network_name}"
  description = "Public Firewall rules"

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["22", "80"]
  }
}
