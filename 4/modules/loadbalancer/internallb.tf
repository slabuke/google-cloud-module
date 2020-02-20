#-----------------------------internal loadbalancer----------------------

resource "google_compute_region_backend_service" "int-lb" {
  name          = "int-lb"
  health_checks = ["${google_compute_health_check.db-tcp-health-check.self_link}"]
  region        = "us-central1"

  backend {
    group = "${var.private_managed_group}"
  }
}

#-----------------------------health check----------------------

resource "google_compute_health_check" "db-tcp-health-check" {
  name = "db-tcp-health-check"

  tcp_health_check {
    port = "80"
  }
}

#-----------------------------forwarding rules----------------------

resource "google_compute_forwarding_rule" "db-int-lb-forwarding-rule" {
  name                  = "db-int-lb-forwarding-rule"
  load_balancing_scheme = "INTERNAL"
  ports                 = ["5432"]
  network               = "${var.network_name}"
  subnetwork            = "${var.Subnet_2}"
  backend_service       = "${google_compute_region_backend_service.int-lb.self_link}"
}
