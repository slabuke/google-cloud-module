#==============================Create Public Subnet============

resource "google_compute_subnetwork" "Subnet-1" {
  name          = "${var.Subnet-1-name}"
  region        = "${var.region}"
  network       = "${google_compute_network.andrei-leanovich-vpc.self_link}"
  description   = "Public subnet"
  ip_cidr_range = "${var.cidr-block-1}"
}

output "gateway_address1" {
  value       = "${google_compute_subnetwork.Subnet-1.gateway_address}"
  description = "The IP address of the gateway."
}

output "Subnet-1-name" {
  value = "${google_compute_subnetwork.Subnet-1.name}"
}

#============================Create Private Subnet===============

resource "google_compute_subnetwork" "Subnet-2" {
  name          = "${var.Subnet-2-name}"
  region        = "${var.region}"
  network       = "${google_compute_network.andrei-leanovich-vpc.self_link}"
  description   = "Private subnet"
  ip_cidr_range = "${var.cidr-block-2}"
}

output "gateway_address2" {
  value       = "${google_compute_subnetwork.Subnet-2.gateway_address}"
  description = "The IP address of the gateway."
}

output "Subnet-2-name" {
  value = "${google_compute_subnetwork.Subnet-2.name}"
}
