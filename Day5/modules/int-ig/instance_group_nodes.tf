resource "google_compute_region_autoscaler" "day4-ig-nodes" {
  name   = "day4-ig-nodes"
  region = "us-central1"
  target = "${google_compute_region_instance_group_manager.day4-igm-nodes.self_link}"

  autoscaling_policy {
    max_replicas    = 3
    min_replicas    = 3
    cooldown_period = 60

    cpu_utilization {
      target = 0.5
    }
  }
}

data "google_compute_region_instance_group" "day4-ig-nodes" {
  name = "day4-ig-nodes"
  region = "us-central1"
}

resource "google_compute_region_instance_group_manager" "day4-igm-nodes" {
  name = "day4-igm-nodes"
  target_size = "3"
  base_instance_name = "db-node"
  region = "us-central1"
  instance_template  = "${google_compute_instance_template.db-node.self_link}"

}

output "instance-group-i" {
  value = "${google_compute_region_instance_group_manager.day4-igm-nodes.instance_group}"
}
