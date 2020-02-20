resource "google_compute_firewall" "firewall-private" {
  name        = "${var.Subnet-2-name}"
  network     = "${var.network_name}"
  description = "Private Firewall rules"

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["80", "22", "8080"]
  }

  source_ranges = ["${var.Subnet-2-ip_cidr_range}"]

  depends_on = [
    "google_compute_subnetwork.Subnet-2",
  ]
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
    ports    = ["80"]
  }

  depends_on = [
    "google_compute_subnetwork.Subnet-1",
  ]

  target_tags = ["http"]
}

resource "google_compute_firewall" "ssh-open" {
  name        = "ssh-open"
  network     = "${var.network_name}"
  description = "open ssh trafiic to internal resource"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  target_tags = ["ssh"]
}

resource "google_compute_firewall" "db-port-open" {
  name        = "db-port-open"
  network     = "${var.network_name}"
  description = "open ssh trafiic to internal resource"

  allow {
    protocol = "tcp"
    ports    = ["5432"]
  }

  target_tags = ["db"]
}
