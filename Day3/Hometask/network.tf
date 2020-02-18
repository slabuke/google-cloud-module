resource "google_compute_network" "pavel-vpc" {
  name                    = "${var.network_name}"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "net1" {
  name          = "${var.net1}"
  region        = "${var.network-region}"
  network       = "${google_compute_network.pavel-vpc.self_link}"
  ip_cidr_range = "${var.range1}"
}

resource "google_compute_subnetwork" "net2" {
  name          = "${var.net2}"
  region        = "${var.network-region}"
  network       = "${google_compute_network.pavel-vpc.self_link}"
  ip_cidr_range = "${var.range2}"
}

resource "google_compute_firewall" "firewall-private" {
  name        = "firewall-private"
  network     = "${var.network_name}"

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }

  source_ranges = ["${var.range2}"]
}

resource "google_compute_firewall" "firewall-public" {
  name        = "firewall-public"
  network     = "${var.network_name}"

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["22", "80"]
  }
}
