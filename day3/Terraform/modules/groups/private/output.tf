output "instance-group_name" {
  value = "https://www.googleapis.com/compute/v1/projects/${var.project}/regions/${var.region}/instanceGroups/${google_compute_region_instance_group_manager.igm-db.name}"
}

output "igm-db-self_link" {
  value = "${google_compute_region_instance_group_manager.igm-db.self_link}"
}
