resource "google_compute_global_forwarding_rule" "global_forwarding_rule" {
  name = "nginx-forwarding-rule"
  project = "${var.project}"
  target = "${google_compute_target_http_proxy.target_http_proxy.self_link}"
  port_range = "80"
}


# used by one or more global forwarding rule to route incoming HTTP requests to a URL map
resource "google_compute_target_http_proxy" "target_http_proxy" {
  name = "nginx-proxy"
  project = "${var.project}"
  url_map = "${google_compute_url_map.url_map.self_link}"
}

# used to route requests to a backend service based on rules that you define for the host and path of an incoming URL
resource "google_compute_url_map" "url_map" {
  name = "nginx-load-balancer"
  project = "${var.project}"
  default_service = "${google_compute_backend_service.backend_service.self_link}"
}

# defines a group of virtual machines that will serve traffic for load balancing
resource "google_compute_backend_service" "backend_service" {
  name = "nginx-backend-service"
  project = "${var.project}"
  port_name = "http"
  protocol = "HTTP"
  health_checks = [ "${var.health_check}"]  

  backend {
    group = "${var.web_private_group}"
    balancing_mode = "RATE"
    max_rate_per_instance = 100
  }
}
