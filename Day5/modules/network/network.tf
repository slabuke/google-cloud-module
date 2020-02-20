resource "google_compute_subnetwork" "public-sub" {
  name          = "publicsubnetwork"
  ip_cidr_range = "10.5.1.0/24"
  network       = "${google_compute_network.day4-network.self_link}"
}

resource "google_compute_subnetwork" "private-sub" {
  name          = "privatesubnetwork"
  ip_cidr_range = "10.5.2.0/24"
  network       = "${google_compute_network.day4-network.self_link}"
}

resource "google_compute_network" "day4-network" {
  name = "day4-network"
  description = "net"
  routing_mode = "GLOBAL"
  auto_create_subnetworks = false
}

resource "google_compute_firewall" "ext-firewall" {
  name    = "ext-firewall"
  network = "day4-network"
  description = "pub firewall"

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports = ["22", "80"]
  }
target_tags = ["web"]
}

resource "google_compute_firewall" "int-firewall" {
  name    = "int-firewall"
  network = "day4-network"
  description = "int firewall"

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports = ["22", "80"]
  }
target_tags = ["int"]

}

resource "google_compute_address" "nat-ip" {
    name = "lb-static-ip"

    region  = "us-central1"
  }


  resource "google_compute_router" "nat-router" {
    name = "nat-router"
    network = "day4-network"
  }

resource "google_compute_router_nat" "nat-gateway" {
  name                               = "nat-gateway"
  router                             = "${google_compute_router.nat-router.name}"
  nat_ip_allocate_option             = "MANUAL_ONLY"
  nat_ips                            = [ "${google_compute_address.nat-ip.self_link}" ]
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES" 
  //depends_on                         = [ "${google_compute_address.nat-ip.self_link}" ]
}
