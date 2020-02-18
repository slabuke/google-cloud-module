resource "google_compute_firewall" "int-firewall" {
  name    = "priv-${var.firewall}"
  network = "${var.network}"
  description = "int firewall rules"
  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports = ["0-65535"]
  }
  source_ranges = ["10.5.2.0/24"]
}

resource "google_compute_firewall" "ext-firewall" {
  name    = "pub-${var.firewall}"
  network = "${var.network}"
  description = "pub firewall"

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports = ["22", "80"]
  }

}

resource "google_compute_subnetwork" "public-sub" {
  name          = "sub-pub-${var.network}"
  ip_cidr_range = "10.5.1.0/24"
  region        = "us-central1"
  network       = "${google_compute_network.network.self_link}"
}

resource "google_compute_subnetwork" "private-sub" {
  name          = "sub-priv-${var.network}"
  ip_cidr_range = "10.5.2.0/24"
  region        = "us-central1"
  network       = "${google_compute_network.network.self_link}"
}

resource "google_compute_network" "network" {
  name = "${var.network}"
  description = "net"
  auto_create_subnetworks = false
}
