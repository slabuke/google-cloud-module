resource "google_compute_target_pool" "inner_load_balancer" {
  name = "inner-load-balancer"
}

resource "google_compute_region_instance_group_manager" "private_group" {
  name = "instance-group-pr-manager"
  target_size = "${var.pr_target_size}"
  base_instance_name = "pr-server"
  region = "${var.region}"
  distribution_policy_zones  = ["us-central1-a", "us-central1-b", "us-central1-c"]

  instance_template = "${google_compute_instance_template.db.self_link}"
  target_pools  = ["${google_compute_target_pool.inner_load_balancer.self_link}"]
}

resource "google_compute_instance_template" "db" {
  name = "db-template"
  machine_type = "${var.machine_type}"
  can_ip_forward = true
  tags = "${var.db_tags}"

  disk {
    source_image = "${var.source_image}"
    auto_delete = true
    boot = true
  }

  network_interface {
    network = "${var.student_name}-vpc"
    subnetwork = "${var.private_subnetwork}"
  }

  scheduling {
    automatic_restart = true
    on_host_maintenance = "MIGRATE"
  }
}

output "private_managed_group" {
  value = "${google_compute_region_instance_group_manager.private_group.instance_group}"
}