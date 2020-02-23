resource "google_compute_forwarding_rule" "db-rule" {
  name   = "${var.name}"
  region = "${var.region}"
  load_balancing_scheme = "INTERNAL"
  ports                 = ["80", "5432"]
  network               = "${var.vpc-name}"
  subnetwork            = "${var.sub-vpc-private-name}"
  backend_service       = "${google_compute_region_backend_service.db-backend.self_link}"
}

resource "google_compute_region_backend_service" "db-backend" {
  name          = "${var.backend_name}"
  region        = "${var.region}"
  health_checks = ["${google_compute_health_check.hc.self_link}"]

    backend {
    group = "${var.ign}"
  }
}

resource "google_compute_health_check" "hc" {
  name               = "${var.hcheck_name}"
  check_interval_sec = 1
  timeout_sec        = 1

  tcp_health_check {
    port = "80"
  }
}
