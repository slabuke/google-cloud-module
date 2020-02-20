// Forwarding rule for Internal Load Balancing
resource "google_compute_forwarding_rule" "int-forw" {
  name   = "int-forw"
  region = "us-central1"

  load_balancing_scheme = "INTERNAL"
  backend_service       = "${google_compute_region_backend_service.db-node.self_link}"
  all_ports             = false
  network               = "day4-network"
  subnetwork            = "privatesubnetwork"
  ports = ["80"]
}

resource "google_compute_region_backend_service" "db-node" {
  name          = "db-node"
  region        = "us-central1"
  health_checks = ["${google_compute_health_check.hc.self_link}"]
  backend {
  group = "${var.instance-group-i}"
  }
}

resource "google_compute_health_check" "hc" {
  name               = "hc"
  check_interval_sec = 1
  timeout_sec        = 1

  tcp_health_check {
    port = "80"
  }
}

variable "instance-group-i" {

}
