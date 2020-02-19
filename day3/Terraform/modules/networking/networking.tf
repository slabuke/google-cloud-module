# Revise variables.tf for vars

resource "google_compute_firewall" "task5-firewall-private" {
  name    = "${var.FirewallName}-private"
  network = "${var.student_name}-vpc"
  description = "Private Firewall rules for Task5"
  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports = ["0-65535"]
  }
  source_ranges = ["10.8.2.0/24"]
}

resource "google_compute_firewall" "task5-firewall-public" {
  depends_on = ["google_compute_network.vpc_network"]
  name    = "${var.FirewallName}-public"
  network = "${var.student_name}-vpc"
  description = "Public Firewall rules for Task5"

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports = ["80"]
  }
}

resource "google_compute_firewall" "task5-firewall-bastion" {
  depends_on = ["google_compute_network.vpc_network"]
  name    = "${var.FirewallName}-bastion"
  network = "${var.student_name}-vpc"
  description = "Public Firewall rules for Bastion"

  allow {
    protocol = "tcp"
    ports = ["22"]
  }
  target_tags = ["bastion"]
}

resource "google_compute_firewall" "task5-firewall-public-internal" {
  depends_on = ["google_compute_network.vpc_network"]
  name    = "${var.FirewallName}-public-internal"
  network = "${var.student_name}-vpc"
  description = "Internal Public subnet Firewall rules for Task5"
  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports = ["0-65535"]
  }
  source_ranges = ["10.8.1.0/24"]
}

resource "google_compute_subnetwork" "public-sub" {
  name          = "sub-${var.student_name}-public"
  description = "Public subnetwork for Task5"
  ip_cidr_range = "10.8.1.0/24"
  region        = "us-central1"
  network       = "${google_compute_network.vpc_network.self_link}"
}

resource "google_compute_subnetwork" "private-sub" {
  name          = "sub-${var.student_name}-private"
  description = "Private subnetwork for Task5"
  ip_cidr_range = "10.8.2.0/24"
  region        = "us-central1"
  network       = "${google_compute_network.vpc_network.self_link}"
}

resource "google_compute_network" "vpc_network" {
  name = "${var.student_name}-vpc"
  description = "VPC network for Task5"
  auto_create_subnetworks = false
}
