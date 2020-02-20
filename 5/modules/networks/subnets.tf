resource "google_compute_subnetwork" "Subnet-1" {
  name          = "${var.Subnet-1-name}"
  region        = "${var.network-region}"
  network       = "${google_compute_network.andrei-vpc.self_link}"
  description   = "Public range"
  ip_cidr_range = "${var.Subnet-1-ip_cidr_range}"
}
output "gateway_address1" {
  value       = "${google_compute_subnetwork.Subnet-1.gateway_address}"
  description = "The IP address of the gateway."
}

output "Subnet-1-name" {
  value       = "${google_compute_subnetwork.Subnet-1.name}"
}
resource "google_compute_subnetwork" "Subnet-2" {
  name          = "${var.Subnet-2-name}"
  region        = "${var.network-region}"
  network       = "${google_compute_network.andrei-vpc.self_link}"
  description   = "Private range"
  ip_cidr_range = "${var.Subnet-2-ip_cidr_range}"
}

output "gateway_address2" {
  value       = "${google_compute_subnetwork.Subnet-2.gateway_address}"
  description = "The IP address of the gateway."
}

output "Subnet-2-name" {
  value       = "${google_compute_subnetwork.Subnet-2.name}"
}

