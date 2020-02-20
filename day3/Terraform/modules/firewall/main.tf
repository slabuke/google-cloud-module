# Revise vars.tf for vars

resource "google_compute_firewall" "task5-firewall-private" {
  name    = "${var.FirewallName}-private"
  network = "${var.vpc-self_link}"
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
#  depends_on = ["google_compute_network.vpc_network"]
  name    = "${var.FirewallName}-public"
  network = "${var.vpc-self_link}"
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
#  depends_on = ["google_compute_network.vpc_network"]
  name    = "${var.FirewallName}-bastion"
  network = "${var.vpc-self_link}"
  description = "Public Firewall rules for Bastion"

  allow {
    protocol = "tcp"
    ports = ["22"]
  }
  target_tags = ["bastion"]
}

resource "google_compute_firewall" "task5-firewall-public-internal" {
#  depends_on = ["google_compute_network.vpc_network"]
  name    = "${var.FirewallName}-public-internal"
  network = "${var.vpc-self_link}"
  description = "Internal Public subnet Firewall rules for Task5"
  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports = ["0-65535"]
  }
  source_ranges = ["10.0.0.0/24"]
}

variable "vpc-self_link" {}