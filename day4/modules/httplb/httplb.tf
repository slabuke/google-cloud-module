variable "tempnginx" {}

resource "google_compute_region_instance_group_manager" "public-ingr" {
  name  = "public-ingr"
  target_size = "1"
  base_instance_name = "nginx"
  region = "us-central1"
  instance_template  = "${var.tempnginx}"
}

resource "google_compute_global_address" "nginx-lb" {
  name = "nginx-lb"
}

resource "google_compute_global_forwarding_rule" "nginx-lb" {
  name = "nginx-lb"
  target = "${google_compute_target_http_proxy.nginx-lb.self_link}"
  port_range = "80"
}

resource "google_compute_target_http_proxy" "nginx-lb" {
  name = "nginx-lb"
  url_map = "${google_compute_url_map.nginx-lb.self_link}"
}

resource "google_compute_url_map" "nginx-lb" {
  name = "nginx-lb"
  default_service = "${google_compute_backend_service.backend-service.self_link}"
}

resource "google_compute_backend_service" "backend-service" {
  name = "nginx-backend-service"
  port_name = "http"
  protocol    = "HTTP"
  timeout_sec = 10
  health_checks = ["${google_compute_health_check.health.self_link}"]

  backend {
    group = "${google_compute_region_instance_group_manager.public-ingr.instance_group}"
    balancing_mode = "UTILIZATION"
    capacity_scaler = 1.0
  }
}

resource "google_compute_health_check" "health" {
  name = "health"
  timeout_sec = 1
  check_interval_sec = 1
  http_health_check {
    port = 80
  }
}
