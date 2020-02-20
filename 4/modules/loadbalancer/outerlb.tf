#-----------------------------outer loadbalancer----------------------

resource "google_compute_global_address" "web-lb" {
  name = "web-lb"
}

#-----------------------------forward rule----------------------
resource "google_compute_global_forwarding_rule" "web-lb" {
  name       = "web-lb"
  target     = "${google_compute_target_http_proxy.web-lb.self_link}"
  port_range = "80"
}

#-----------------------------web lb---------------------
resource "google_compute_url_map" "web-lb" {
  name            = "web-lb"
  default_service = "${google_compute_backend_service.backend-service.self_link}"
}

#---------------------------------http proxy-----------------
resource "google_compute_target_http_proxy" "web-lb" {
  name    = "web-lb"
  url_map = "${google_compute_url_map.web-lb.self_link}"
}

#---------------------------------backend-----------------
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

#---------------------------------healthcheck-----------------
resource "google_compute_health_check" "health" {
  name               = "nginx-health"
  timeout_sec        = 3
  check_interval_sec = 3

  http_health_check {
    port = 80
  }
}
