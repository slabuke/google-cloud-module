# module "gce-ilb" {
#   source       = "GoogleCloudPlatform/lb-internal/google"
#   version      = "1.0.4"
#   region       = "${var.Region}"
#   name         = "db-ilb"
#   # network      = "${var.vpc-name}"
# #  subnetwork      = "${var.sub-vpc-private-name}"
#   ports        = ["80", "5432"]
#   health_port = "80"
#   source_tags  = "${var.STags}"
#   target_tags  = "${var.DTags}"
#   backends = [
#       { group = "${var.instance-group_name}" }
#   ]
# }

resource "google_compute_forwarding_rule" "db-rule" {
  name   = "db-lb"
  region = "${var.Region}"
  load_balancing_scheme = "INTERNAL"
  ports                 = ["80", "5432"]
  network               = "${var.vpc-name}"
  subnetwork            = "${var.sub-vpc-private-name}"
  backend_service       = "${google_compute_region_backend_service.db-backend.self_link}"
}

resource "google_compute_region_backend_service" "db-backend" {
  name          = "db-backend"
  region        = "${var.Region}"
  health_checks = ["${google_compute_health_check.hc.self_link}"]

    backend {
    group = "${var.instance-group_name}"
  }
}

resource "google_compute_health_check" "hc" {
  name               = "check-backend"
  check_interval_sec = 1
  timeout_sec        = 1

  tcp_health_check {
    port = "80"
  }
}

variable "instance-group_name" {}
