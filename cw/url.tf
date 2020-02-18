output "url" {
  value = "${google_compute_instance.v.*.network_interface.0.access_config.0.nat_ip }"
}p}"
