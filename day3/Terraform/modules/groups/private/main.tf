# Revise vars.tf for vars

data "google_compute_region_instance_group" "db-group" {
  name = "${var.name}"
  region = "${var.region}"
}

resource "google_compute_region_instance_group_manager" "igm-db" {
  name = "${var.name}"
  distribution_policy_zones  = "${var.zones}"
  target_size = "${var.size}"
  base_instance_name = "nginx-db"
  region = "${var.region}"
  instance_template  = "${var.template}"
}