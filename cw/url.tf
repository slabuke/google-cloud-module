output "url" {
  value = "${google_compute_instance.nginx-classwork-terraform.*.network_interface.0.access_config.0.nat_ip }"
}
