resource "google_compute_firewall" "firewall" {
  name    = "${var.fname}-private"
  network = "${var.sname}-vpc"
  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports = ["0-65535"]
  }
  source_ranges = ["10.2.2.0/24"]
}

resource "google_compute_firewall" "firewall-public" {
  name    = "${var.fname}-public"
  network = "${var.sname}-vpc"
 

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports = ["22", "80"]
  }

}

resource "google_compute_subnetwork" "public-sub" {
  name          = "sub-${var.sname}-public"
  ip_cidr_range = "10.2.1.0/24"
  region        = "us-central1"
  network       = "${google_compute_network.vpc_network.self_link}"
}

resource "google_compute_subnetwork" "private-sub" {
  name          = "sub-${var.sname}-private"
  ip_cidr_range = "10.2.2.0/24"
  region        = "us-central1"
  network       = "${google_compute_network.vpc_network.self_link}"
}

resource "google_compute_network" "vpc_network" {
  name = "${var.sname}-vpc"
  auto_create_subnetworks = false
}
