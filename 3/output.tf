output "gateway_address" {
  value       = "${google_compute_subnetwork.Subnet-1.gateway_address}"
  description = "The IP address of the gateway."
}

output "self_link" {
  value       = "${google_compute_subnetwork.Subnet-1.self_link}"
  description = "The URL of the created resource"
}

output "IPs" {
  value = "http://${google_compute_instance.nginx-terraform.network_interface.0.access_config.0.nat_ip }"
}
