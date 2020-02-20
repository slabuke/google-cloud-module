resource "google_compute_global_address" "default" {
  name = "global-appserver-ip"
  
}

resource "google_compute_global_forwarding_rule" "default" {
  name       = "global-rule"
  target     = "${google_compute_target_http_proxy.loadbalancer.self_link}"
  port_range = "80"
}

resource "google_compute_target_http_proxy" "loadbalancer" {
  name    = "loadbalancer"
  url_map = "${google_compute_url_map.loadbalancer.self_link}"
}

resource "google_compute_url_map" "loadbalancer" {
  name            = "loadbalancer"
  default_service = "${google_compute_backend_service.loadbalancer.self_link}"
}

resource "google_compute_backend_service" "loadbalancer" {
  name        = "loadbalancer"
  
  protocol    = "HTTP"
  timeout_sec = 10

  health_checks = ["${google_compute_health_check.nginx-health.self_link}"]

  backend {
    group = "${var.instance-group}"
    balancing_mode = "UTILIZATION"
    capacity_scaler = 1.0
  }
}

resource "google_compute_health_check" "nginx-health" {
  name = "nginx-health"
  timeout_sec = 1
  check_interval_sec = 1
  http_health_check {
    port = 80
  }
}

variable "instance-group" {

}
