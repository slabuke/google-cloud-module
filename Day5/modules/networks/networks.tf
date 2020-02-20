#======================Create VPC==========================

resource "google_compute_network" "andrei-leanovich-vpc" {
  name                    = "${var.vpc_name}"
  description             = "VPC network"
  auto_create_subnetworks = false
}

#====================Output VPC==============================

output "vpc_name" {
  value = "${google_compute_network.andrei-leanovich-vpc.name}"
}
