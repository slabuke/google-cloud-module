output "dbt" {
    value = "${google_compute_instance_template.db.self_link}"
}

output "nginxt" {
    value = "${google_compute_instance_template.nginx.self_link}"
}

