# Create Internal load-balancer from private group
resource "google_compute_region_backend_service" "int-lb" {
  name          = "int-lb"
  health_checks = ["${google_compute_health_check.db-tcp-health-check.self_link}"]
  region        = "us-central1"

  backend {
    group = "${var.private_managed_group}"
  }
}

resource "google_compute_health_check" "db-tcp-health-check" {
  name = "db-tcp-health-check"

  tcp_health_check {
    port = "80"
  }
}

# Create forward rule to VM in private zone via internal load-balancer
resource "google_compute_forwarding_rule" "db-int-lb-forwarding-rule" {
  name                  = "db-int-lb-forwarding-rule"
  load_balancing_scheme = "INTERNAL"
  ports                 = ["5432"]
  network               = "${var.network_name}"
  subnetwork            = "${var.subnet-2-name}"
  backend_service       = "${google_compute_region_backend_service.int-lb.self_link}"
}

# Create auto-scaler for private group instances
resource "google_compute_region_autoscaler" "db-servers" {
  name   = "db-servers-autoscaler"
  region = "us-central1"
  target = "${var.private_managed_group_link}"

  autoscaling_policy {
    max_replicas    = 9
    min_replicas    = 3
    cooldown_period = 90

    cpu_utilization {
      target = 0.8
    }
  }
}
