output "vpc-self_link" {
  value = "${google_compute_network.vpc_network.self_link}"
}

output "vpc-name" {
  value = "${google_compute_network.vpc_network.name}"
}

output "sub-vpc-public-self_link" {
  value = "${google_compute_subnetwork.public-sub.self_link}"
}

output "sub-vpc-public-name" {
  value = "${google_compute_subnetwork.public-sub.name}"
}

output "sub-vpc-private-self_link" {
  value = "${google_compute_subnetwork.private-sub.self_link}"
}

output "sub-vpc-private-name" {
  value = "${google_compute_subnetwork.private-sub.name}"
}