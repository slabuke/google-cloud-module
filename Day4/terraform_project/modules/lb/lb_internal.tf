resource "google_compute_region_backend_service" "my-int-lb" {
  name          = "my-int-lb"
  health_checks = ["${google_compute_health_check.my-tcp-health-check.self_link}"]
  region        = "us-central1"

  backend {
    group = "${var.db_group}"
  }
}

resource "google_compute_health_check" "my-tcp-health-check" {
  name = "my-tcp-health-check"

  tcp_health_check {
    port = "80"
  }
}

resource "google_compute_forwarding_rule" "my-int-lb-forwarding-rule" {
  name                  = "my-int-lb-forwarding-rule"
  load_balancing_scheme = "INTERNAL"
  ports                 = ["80"]
  network               = "${var.network_name}"
  subnetwork            = "${var.subnet-private}"
  backend_service       = "${google_compute_region_backend_service.my-int-lb.self_link}"
}

