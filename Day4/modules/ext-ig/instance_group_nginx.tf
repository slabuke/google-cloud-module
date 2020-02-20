resource "google_compute_region_autoscaler" "day4-ig" {
  name   = "day4-ig"
  region = "us-central1"
  target = "${google_compute_region_instance_group_manager.day4-igm.self_link}"

  autoscaling_policy {
    max_replicas    = 1
    min_replicas    = 1
    cooldown_period = 60

    cpu_utilization {
      target = 0.5
    }
  }
}

data "google_compute_region_instance_group" "day4-ig" {
  name = "day4-ig"
  region = "us-central1"
}

resource "google_compute_region_instance_group_manager" "day4-igm" {
  name = "day4-igm"
  target_size = "1"
  base_instance_name = "site"
  region = "us-central1"
  instance_template  = "${google_compute_instance_template.site.self_link}"

}

output "instance-group" {
  value = "${google_compute_region_instance_group_manager.day4-igm.instance_group}"
}
