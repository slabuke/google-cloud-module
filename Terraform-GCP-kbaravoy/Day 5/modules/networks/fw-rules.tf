# Create public FW rules for subnet-1
resource "google_compute_firewall" "firewall-public" {
  name        = "${var.subnet-1-name}"
  network     = "${google_compute_network.kbaravoy-vpc.self_link}"

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  depends_on = [
    "google_compute_subnetwork.subnet-1",
  ]

  target_tags = ["http"]
}

# Create FW rules - accept external SSH connection to bastion-host via tags=ssh
resource "google_compute_firewall" "ssh-external" {
  name        = "ssh-external"
  network     = "${google_compute_network.kbaravoy-vpc.self_link}"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  target_tags = ["ssh"]
}

# Create FW rules - accept internal SSH connection to any hosts via tags=ssh-init
resource "google_compute_firewall" "ssh-internal" {
  name        = "ssh-internal"
  network     = "${google_compute_network.kbaravoy-vpc.self_link}"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["${var.subnet-1-range}"]
  target_tags   = ["ssh-int"]
}

# Create FW rules - allow connect to backend VM via port 5432 and tags=db from sub-1 and sub-2 netwroks
resource "google_compute_firewall" "db-port-open" {
  name        = "db-port-open"
  network     = "${google_compute_network.kbaravoy-vpc.self_link}"

  allow {
    protocol = "tcp"
    ports    = ["5432"]
  }

  source_ranges = ["${var.subnet-1-range}", "${var.subnet-2-range}"]
  target_tags   = ["db"]
}

# Output for main.tf
output "google_compute_firewall_ssh_name" {
  value = "${google_compute_firewall.ssh-external.self_link}"
}
