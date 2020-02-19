resource "google_compute_network" "vpc_network" {
  name = "${var.Student_name}-vpc"
  description = "vps network"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "public-sub" {
  name          = "sub-${var.Student_name}-public"
  ip_cidr_range = "10.10.1.0/24"
  region        = "us-central1"
  network       = "${google_compute_network.vpc_network.self_link}"
}

resource "google_compute_subnetwork" "private-sub" {
  name          = "sub-${var.Student_name}-private"
  ip_cidr_range = "10.10.2.0/24"
  region        = "us-central1"
  network       = "${google_compute_network.vpc_network.self_link}"
}

resource "google_compute_firewall" "firewall-public" {
  name    = "sub-${var.Student_name}-public"
  network = "${var.Student_name}-vpc"
  description = "Public Firewall rules"

  allow {
    protocol = "tcp"
    ports = ["22", "80"]
  }

  depends_on = ["google_compute_subnetwork.public-sub"]
}

resource "google_compute_firewall" "firewall-private" {
  name    = "sub-${var.Student_name}-private"
  network = "${var.Student_name}-vpc"
  description = "Private Firewall rules"

  allow {
    protocol = "tcp"
    ports = ["0-65535"]
  }

  source_ranges = ["10.10.2.0/24"]

  depends_on = ["google_compute_subnetwork.private-sub"]
}
