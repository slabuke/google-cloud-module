output "template-self_link" {
  value = "${google_compute_instance_template.nginx-db.self_link}"
}