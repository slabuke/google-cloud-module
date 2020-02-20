resource "google_compute_region_autoscaler" "igm-autoscaler-web" {
  name   = "igm-autoscaler-web"
  region = "${var.Region}"
  target = "${var.igm-web-self_link}"

  autoscaling_policy {
    max_replicas    = 3
    min_replicas    = 1
    cooldown_period = 60

    cpu_utilization {
      target = 0.5
    }
  }
}

variable "igm-web-self_link" {}