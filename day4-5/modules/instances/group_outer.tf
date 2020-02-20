resource "google_compute_target_pool" "web_load_balancer" {
  name = "web-load-balancer"
}

resource "google_compute_region_instance_group_manager" "public_group" {
  name = "instance-group-pb-manager"
  target_size  = "${var.pb_target_size}"
  base_instance_name = "webserver"
  region = "${var.region}"
  distribution_policy_zones  = ["us-central1-a", "us-central1-b", "us-central1-c"]

  instance_template = "${google_compute_instance_template.nginxserver.self_link}"
  target_pools = ["${google_compute_target_pool.web_load_balancer.self_link}"]
}

resource "google_compute_instance_template" "nginxserver" {
  name  = "webserver-template"
  machine_type = "${var.machine_type}"
  can_ip_forward = true
  tags = "${var.nginx_tags}"

  disk {
    source_image = "${var.source_image}"
    auto_delete  = true
    boot = true
  }

  network_interface {
    network = "${var.student_name}-vpc"
    subnetwork = "${var.public_subnetwork}"
    access_config = {}
  }

  scheduling {
    automatic_restart = true
    on_host_maintenance = "MIGRATE"
  }

  metadata_startup_script ="${var.script}"
}
output "public_managed_group" {
  value = "${google_compute_region_instance_group_manager.public_group.instance_group}"
}