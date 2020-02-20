# Revise vars.tf for vars

data "google_compute_region_instance_group" "nginx-group" {
  name = "nginx-group"
  region = "${var.Region}"
}

resource "google_compute_region_instance_group_manager" "igm-web" {
  name = "nginx-group"
  distribution_policy_zones  = ["us-central1-a", "us-central1-b", "us-central1-c"]
  target_size = "1"
  base_instance_name = "nginx-web"
  region = "${var.Region}"
  instance_template  = "${var.template-self_link}"
}