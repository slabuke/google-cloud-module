resource "google_compute_region_backend_service" "inner_load_balancer" {
  name = "inner-load-balancer"
  health_checks = ["${google_compute_health_check.tcp_health_check.self_link}"]
  region = "us-central1"

  backend {
    group = "${var.private_managed_group}"
  }
}

resource "google_compute_health_check" "tcp_health_check" {
  name = "tcp-health-check"

  tcp_health_check {
    port = "80"
  }
}

resource "google_compute_forwarding_rule" "inner_lb_forwarding-rule" {
  name = "inner-lb-forwarding-rule"
  network = "${var.student_name}-vpc"
  subnetwork = "${var.private_subnetwork}"
  load_balancing_scheme = "INTERNAL"
  ports = ["5432"]
  backend_service = "${google_compute_region_backend_service.inner_load_balancer.self_link}"
}
