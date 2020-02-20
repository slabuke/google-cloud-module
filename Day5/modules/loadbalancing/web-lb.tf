#=========================Create http loadbalancer==========

resource "google_compute_global_address" "web-lb" {
  name = "web-lb"
}

resource "google_compute_global_forwarding_rule" "web-lb" {
  name       = "web-lb"
  target     = "${google_compute_target_http_proxy.web-lb.self_link}"
  port_range = "80"
}

resource "google_compute_target_http_proxy" "web-lb" {
  name    = "web-lb"
  url_map = "${google_compute_url_map.web-lb.self_link}"
}

resource "google_compute_url_map" "web-lb" {
  name            = "web-lb"
  default_service = "${google_compute_backend_service.backend-service.self_link}"
}

resource "google_compute_backend_service" "backend-service" {
  name          = "nginx-backend-service"
  port_name     = "http"
  protocol      = "HTTP"
  timeout_sec   = 10
  health_checks = ["${google_compute_health_check.health.self_link}"]

  backend {
    group           = "${var.public_managed_group}"
    balancing_mode  = "UTILIZATION"
    capacity_scaler = 1.0
  }
}

resource "google_compute_health_check" "health" {
  name               = "nginx-health"
  timeout_sec        = 2
  check_interval_sec = 2

  http_health_check {
    port = 80
  }
}

resource "google_compute_region_autoscaler" "web-servers" {
  name   = "web-servers-autoscaler"
  region = "us-central1"
  target = "${var.public_managed_group_link}"

  autoscaling_policy {
    max_replicas    = 2
    min_replicas    = 1
    cooldown_period = 90

    cpu_utilization {
      target = 0.8
    }
  }
}
