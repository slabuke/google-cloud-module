resource "google_compute_subnetwork" "public_subnetwork" {
  name = "${var.firewall}-public"
  region = "${var.region}"
  network = "${google_compute_network.networks.self_link}"
  ip_cidr_range = "${var.ip1}"
}

output "gateway_address1" {
  value = "${google_compute_subnetwork.public_subnetwork.gateway_address}"
}

output "public_subnetwork" {
  value  = "${google_compute_subnetwork.public_subnetwork.name}"
}

resource "google_compute_subnetwork" "private_subnetwork" {
  name = "${var.firewall}-private"
  region = "${var.region}"
  network = "${google_compute_network.networks.self_link}"
  ip_cidr_range = "${var.ip2}"
}

output "gateway_address2" {
  value = "${google_compute_subnetwork.private_subnetwork.gateway_address}"
}

output "private_subnetwork" {
  value = "${google_compute_subnetwork.private_subnetwork.name}"
}

