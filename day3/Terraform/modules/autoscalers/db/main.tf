# Revise vars.tf for vars

resource "google_compute_region_autoscaler" "igm-autoscaler-db" {
  name   = "igm-autoscaler-db"
  region = "${var.Region}"
  target = "${var.igm-db-self_link}"

  autoscaling_policy {
    max_replicas    = 5
    min_replicas    = 3
    cooldown_period = 60

    cpu_utilization {
      target = 0.5
    }
  }
}

variable "igm-db-self_link" {}

