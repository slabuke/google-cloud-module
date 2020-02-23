# Revise vars.tf for vars

resource "google_compute_region_autoscaler" "igm-autoscaler-db" {
  name   = "${var.name}"
  region = "${var.region}"
  target = "${var.igm-db}"

  autoscaling_policy {
    max_replicas    = "${var.max}"
    min_replicas    = "${var.min}"
    cooldown_period = 60

    cpu_utilization {
      target = 0.5
    }
  }
}

