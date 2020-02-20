resource "google_compute_firewall" "firewall-public" {
  name        = "${var.Subnet-1-name}"
  network     = "${google_compute_network.andrei-vpc.self_link}"
  description = "Public Firewall rules"

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  depends_on = [
    "google_compute_subnetwork.Subnet-1",
  ]

  target_tags = ["http"]
}

resource "google_compute_firewall" "ssh-external" {
  name        = "ssh-external"
  network     = "${google_compute_network.andrei-vpc.self_link}"
  description = "open ssh trafiic to internal resource"

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
  name        = "ssh-open"
  network     = "${google_compute_network.andrei-vpc.self_link}"
  description = "open ssh trafiic to internal resource"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["${var.Subnet-1-ip_cidr_range}"]
  target_tags   = ["ssh-int"]
}

resource "google_compute_firewall" "db-port-open" {
  name        = "db-port-open"
  network     = "${google_compute_network.andrei-vpc.self_link}"
  description = "open db trafiic to internal mig"

  allow {
    protocol = "tcp"
    ports    = ["5432"]
  }

  source_ranges = ["${var.Subnet-1-ip_cidr_range}", "${var.Subnet-2-ip_cidr_range}"]
  target_tags   = ["db"]
}
