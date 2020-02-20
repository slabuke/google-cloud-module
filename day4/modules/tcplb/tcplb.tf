variable "tempdb"{}
variable "network"{}
variable "privatsub"{}

resource "google_compute_region_instance_group_manager" "privat-ingr" {
  name  = "privat-ingr"
  target_size = "3"
  base_instance_name = "db"
  region = "us-central1"
  instance_template  = "${var.tempdb}"
}

resource "google_compute_forwarding_rule" "db-rule" {
  name   = "db-lb"
  load_balancing_scheme = "INTERNAL"
  ports = ["80"]
  network = "${var.network}"
  subnetwork = "${var.privatsub}"
  backend_service = "${google_compute_region_backend_service.db-backend.self_link}"
}

resource "google_compute_region_backend_service" "db-backend" {
  name          = "db-backend"
  health_checks = ["${google_compute_health_check.hc.self_link}"]

    backend {
    group = "${google_compute_region_instance_group_manager.privat-ingr.instance_group}"
  }
}

resource "google_compute_health_check" "hc" {
  name = "check-backend"
  check_interval_sec = 1
  timeout_sec = 1

  tcp_health_check {
    port = "80"
  }
}

