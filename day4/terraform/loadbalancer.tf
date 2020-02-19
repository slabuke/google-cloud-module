resource "google_compute_global_address" "default" {
  name = "global-appserver-ip"
  network = "day4-network"
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
  name            = "url-map"
  default_service = "${google_compute_backend_service.loadbalancer.self_link}"

  host_rule {
    hosts        = ["site-*"]
    path_matcher = "allpaths"
  }

  path_matcher {
    name            = "allpaths"
    default_service = "${google_compute_backend_service.loadbalancer.self_link}"

    path_rule {
      paths   = ["/*"]
      service = "${google_compute_backend_service.loadbalancer.self_link}"
    }
  }
}

resource "google_compute_backend_service" "loadbalancer" {
  name        = "loadbalancer"
  port_name   = "http"
  protocol    = "HTTP"
  timeout_sec = 10

  health_checks = ["${tolist(data.google_compute_backend_service.loadbalancer.health_checks)[0]}"]

}

resource "google_compute_http_health_check" "hch" {
  name               = "http-health-check"
  request_path       = "/"
  check_interval_sec = 1
  timeout_sec        = 1
}

