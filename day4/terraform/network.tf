resource "google_compute_subnetwork" "public-sub" {
  name          = "publicsubnetwork"
  ip_cidr_range = "10.5.1.0/24"
  network       = "${google_compute_network.network.self_link}"
}

resource "google_compute_subnetwork" "private-sub" {
  name          = "privatesubnetwork"
  ip_cidr_range = "10.5.2.0/24"
  network       = "${google_compute_network.network.self_link}"
}

resource "google_compute_network" "network" {
  name = "day4-network"
  description = "net"
  routing_mode = "GLOBAL"
  auto_create_subnetworks = false
}

resource "google_compute_router" "router" {
  name    = "lb-router"
  region  = "${google_compute_subnetwork.public-sub.region}"
  network = "${google_compute_network.network.self_link}"

  bgp {
    asn = 64514
  }
}

resource "google_compute_router_nat" "nat" {
  name                               = "lb-router-nat"
  router                             = "${google_compute_router.router.name}"
  region                             = "${google_compute_router.router.region}"
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
}
