resource "google_compute_global_address" "web_load_balancer" {
  name = "web-load-balancer"
}

resource "google_compute_global_forwarding_rule" "web_load_balancer" {
  name = "web-load-balancer"
  port_range = "80"
  target = "${google_compute_target_http_proxy.web_load_balancer.self_link}"
}

resource "google_compute_target_http_proxy" "web_load_balancer" {
  name = "web-load-balancer"
  url_map = "${google_compute_url_map.web_load_balancer.self_link}"
}

resource "google_compute_url_map" "web_load_balancer" {
  name = "web-load-balancer"
  default_service = "${google_compute_backend_service.backend-service.self_link}"
}

resource "google_compute_backend_service" "backend-service" {
  name = "nginx-backend-service"
  port_name = "http"
  protocol = "HTTP"
  timeout_sec = 10
  health_checks = ["${google_compute_health_check.health.self_link}"]

  backend {
    group = "${var.public_managed_group}"
    balancing_mode  = "UTILIZATION"
    capacity_scaler = 1.0
  }
}

resource "google_compute_health_check" "health" {
  name = "nginx-health"
  timeout_sec = 2
  check_interval_sec = 5

  http_health_check {
    port = 80
  }
}
