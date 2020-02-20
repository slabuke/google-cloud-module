output "template-self_link" {
  value = "${google_compute_instance_template.nginx-web.self_link}"
}