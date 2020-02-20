#=====================Create firewalls=====================

resource "google_compute_firewall" "firewall-public" {
  name        = "${var.Subnet-1-name}"
  network     = "${google_compute_network.andrei-leanovich-vpc.self_link}"
  description = "Public Firewall rules"

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  target_tags = ["http"]
}

resource "google_compute_firewall" "ssh-external" {
  name    = "ssh-external"
  network = "${google_compute_network.andrei-leanovich-vpc.self_link}"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  target_tags = ["ssh"]
}

output "google_compute_firewall_ssh_name" {
  value = "${google_compute_firewall.ssh-external.self_link}"
}

resource "google_compute_firewall" "ssh-internal" {
  name    = "ssh-open"
  network = "${google_compute_network.andrei-leanovich-vpc.self_link}"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["${var.cidr-block-1}"]
  target_tags   = ["ssh-int"]
}

resource "google_compute_firewall" "db-port-open" {
  name    = "db-port-open"
  network = "${google_compute_network.andrei-leanovich-vpc.self_link}"

  allow {
    protocol = "tcp"
    ports    = ["5432"]
  }

  source_ranges = ["${var.cidr-block-1}", "${var.cidr-block-2}"]
  target_tags   = ["db"]
}
