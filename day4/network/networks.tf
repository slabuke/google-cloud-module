resource "google_compute_network" "maxim-vpc" {
  name = "maxim-vpc"
  auto_create_subnetworks = "false"
  routing_mode = "GLOBAL"
  description = "vpc network for project"
}

resource "google_compute_subnetwork" "public-sub" {
  name          = "public-sub"
  ip_cidr_range = "${var.public-ip_cidr_range}"
  region        = "${var.region[0]}"
  network       = "${google_compute_network.maxim-vpc.name}"
  description = "public subnetwork"
}
resource "google_compute_subnetwork" "private-sub" {
  name          = "private-sub"
  ip_cidr_range = "${var.private-ip_cidr_range}"
  region        = "${var.region[0]}"
  network       = "${google_compute_network.maxim-vpc.name}"
  description = "private subnetwork"
}

resource "google_compute_firewall" "internal-firewall" {
  name    = "internal-firewall"
  network = "${google_compute_network.maxim-vpc.name}"
  description = "open ports for internal traffic"
 allow {
    protocol = "icmp"
  } 

 allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }

  allow {
    protocol = "udp"
    ports    = ["0-65535"]
    
  }
  direction = "EGRESS"
}

resource "google_compute_firewall" "http-open" {
  name    = "http-open"
  network = "${google_compute_network.maxim-vpc.name}"
  description = "open http trafic to internal resource"
allow {
    protocol = "tcp"
    ports    = ["80"]
  }
  target_tags = ["http-server"] 
}
resource "google_compute_firewall" "ssh-open" {
  name    = "ssh-open"
  network = "${google_compute_network.maxim-vpc.name}"
  description = "open ssh trafiic to internal resource"
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  target_tags = ["ssh"]
}

resource "google_compute_firewall" "telnet-open" {
  name    = "telnet-open"
  network = "${google_compute_network.maxim-vpc.name}"
  description = "open ssh trafiic to internal resource"
  allow {
    protocol = "tcp"
    ports    = ["21"]
  }
  target_tags = ["telnet"]
}

resource "google_compute_address" "nat-ip" {
    name = "lb-static-ip"

    region  = "us-central1"
  }

  resource "google_compute_router" "nat-router" {
    name = "nat-router"
    network = "${google_compute_network.maxim-vpc.name}"
  }

resource "google_compute_router_nat" "nat-gateway" {
  name                               = "nat-gateway"
  router                             = "${google_compute_router.nat-router.name}"
  nat_ip_allocate_option             = "MANUAL_ONLY"
  nat_ips                            = [ "${google_compute_address.nat-ip.self_link}" ]
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES" 
  //depends_on                         = [ "${google_compute_address.nat-ip.self_link}" ]
}
