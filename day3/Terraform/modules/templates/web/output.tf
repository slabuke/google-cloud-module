output "template-self_link" {
  value = "${google_compute_instance_template.nginx-web.self_link}"
}

output "instance-ips" {
  value = "${google_compute_instance_template.nginx-web.network_interface.0.access_config.0.nat_ip}"
}