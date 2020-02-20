output "instance-group_name" {
  value = "https://www.googleapis.com/compute/v1/projects/devopslab2020-gcp-module/regions/us-central1/instanceGroups/${google_compute_region_instance_group_manager.igm-web.name}"
}

output "igm-web-self_link" {
  value = "${google_compute_region_instance_group_manager.igm-web.self_link}"
}
