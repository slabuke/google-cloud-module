#---------------------public firewall-------------------------
resource "google_compute_firewall" "firewall-public" {
  name        = "${var.Subnet_1}"
  network     = "${google_compute_network.dmitriy-mv.self_link}"
  description = "Pub Firewall rules"

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  depends_on = [
    "google_compute_subnetwork.Subnet-1",
  ]

  target_tags = ["http"]
}

#---------------------external firewall-------------------------
resource "google_compute_firewall" "ssh-external" {
  name        = "ssh-external"
  network     = "${google_compute_network.dmitriy-mv.self_link}"
  description = "ssh to internal"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  target_tags = ["ssh"]
}

#---------------------firewall-------------------------
output "google_compute_firewall_ssh_name" {
  value = "${google_compute_firewall.ssh-external.self_link}"
}

#---------------------public internal-------------------------
resource "google_compute_firewall" "ssh-internal" {
  name        = "ssh-open"
  network     = "${google_compute_network.dmitriy-mv.self_link}"
  description = "ssh trafiic to internal"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["${var.Subnet1_cidr}"]
  target_tags   = ["ssh-int"]
}

#---------------------port firewall-------------------------
resource "google_compute_firewall" "db-port-open" {
  name        = "db-port-open"
  network     = "${google_compute_network.dmitriy-mv.self_link}"
  description = "db trafiic to internal"

  allow {
    protocol = "tcp"
    ports    = ["5432"]
  }

  source_ranges = ["${var.Subnet1_cidr}", "${var.Subnet2_cidr}"]
  target_tags   = ["db"]
}
