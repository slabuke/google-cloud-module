resource "google_compute_network" "vpc_network" {
  name                    = "vpc-network"
  description             = "my network"
  auto_create_subnetworks = "false"
  routing_mode            = "GLOBAL"
}

resource "google_compute_subnetwork" "subnetpriv" {
  name          = "vpc-private"
  ip_cidr_range = "10.14.2.0/24"
  region        = "us-central1"
  network       = "${google_compute_network.vpc_network.name}"
  description = "private subnetwork"
}

resource "google_compute_subnetwork" "subnetpub" {
  name          = "vpc-public"
  ip_cidr_range = "10.14.1.0/24"
  region        = "us-central1"
  network       = "${google_compute_network.vpc_network.name}"
  description   = "public subnetwork"
}

resource "google_compute_firewall" "external-allow" {
  name        = "vpc-external"
  description = "Allow external 80 port"
  network     = "${google_compute_network.vpc_network.name}"

  allow {
    protocol = "tcp"
    ports    = ["80", "22"]
  }
  source_ranges = ["0.0.0.0/0"]
}


resource "google_compute_firewall" "allow-internal" {
  name    = "vpc-internal"
  network = "${google_compute_network.vpc_network.name}"
  
  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }
  allow {
    protocol = "udp"
    ports    = ["0-65535"]
    
  }
  source_ranges = ["0.0.0.0/0"]
}

  resource "google_compute_address" "nat-ip" {
    name = "lb-static-ip"
    project = "${var.project}"
    region  = "us-central1"
  }


  resource "google_compute_router" "nat-router" {
    name = "nat-router"
    network = "${google_compute_network.vpc_network.name}"
  }

resource "google_compute_router_nat" "nat-gateway" {
  name                               = "nat-gateway"
  router                             = "${google_compute_router.nat-router.name}"
  nat_ip_allocate_option             = "MANUAL_ONLY"
  nat_ips                            = [ "${google_compute_address.nat-ip.self_link}" ]
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES" 
}


output "vpc-output" {
  value       = "${google_compute_network.vpc_network.name}"
}

output "vpc-private" {
  value = "${google_compute_subnetwork.subnetpriv.name}"
}

output "vpc-public" {
  value = "${google_compute_subnetwork.subnetpub.name}"
}
