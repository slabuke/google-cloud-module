output "self_link" {
  value       = "${google_compute_subnetwork.public_subnetwork.self_link}"
  description = "The URL of the created resource"
}

output "nat_ip" {
  value = "http://${google_compute_subnetwork.public_subnetwork.gateway_address}"
}
