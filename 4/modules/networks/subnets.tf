resource "google_compute_subnetwork" "Subnet-1" {
  name          = "${var.Subnet_1}"
  region        = "${var.network-region}"
  network       = "${google_compute_network.dmitriy-mv.self_link}"
  description   = "Pub range"
  ip_cidr_range = "${var.Subnet1_cidr}"
}

resource "google_compute_subnetwork" "Subnet-2" {
  name          = "${var.Subnet_2}"
  region        = "${var.network-region}"
  network       = "${google_compute_network.dmitriy-mv.self_link}"
  description   = "Private range"
  ip_cidr_range = "${var.Subnet2_cidr}"
}

output "gateway_address1" {
  value       = "${google_compute_subnetwork.Subnet-1.gateway_address}"
  description = "Gateway1 IP"
}

output "gateway_address2" {
  value       = "${google_compute_subnetwork.Subnet-2.gateway_address}"
  description = "Gateway2 IP."
}

output "Subnet_1" {
  value = "${google_compute_subnetwork.Subnet-1.name}"
}

output "Subnet_2" {
  value = "${google_compute_subnetwork.Subnet-2.name}"
}
