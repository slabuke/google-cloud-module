# Create subnet-1 10.10.1.0/24 for kbaravoy-vpc
resource "google_compute_subnetwork" "subnet-1" {
  name          = "${var.subnet-1-name}"
  region        = "${var.network-region}"
  network       = "${google_compute_network.kbaravoy-vpc.self_link}"
  ip_cidr_range = "${var.subnet-1-range}"
}

# Output for main.tf
output "subnet-1-name" {
  value       = "${google_compute_subnetwork.subnet-1.name}"
}

# Create subnet-2 10.10.2.0/24 for kbaravoy-vpc
resource "google_compute_subnetwork" "subnet-2" {
  name          = "${var.subnet-2-name}"
  region        = "${var.network-region}"
  network       = "${google_compute_network.kbaravoy-vpc.self_link}"
  ip_cidr_range = "${var.subnet-2-range}"
}

# Output for main.tf
output "subnet-2-name" {
  value       = "${google_compute_subnetwork.subnet-2.name}"
}
