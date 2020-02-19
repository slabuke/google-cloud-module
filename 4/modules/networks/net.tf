resource "google_compute_network" "andrei-vpc" {
  name                    = "${var.network_name}"
  description             = "Main VPC network"
  auto_create_subnetworks = false
}

