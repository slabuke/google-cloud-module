
variable "studname" {}

output "vpc" {
  value = "${google_compute_network.vpc_network.self_link}"
}

output "subnet" {
  value = "${google_compute_subnetwork.subnetpub.self_link}"
}

output "subnetpriv" {
  value = "${google_compute_subnetwork.subnetpriv.self_link}"
}