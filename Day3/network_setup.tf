resource "google_compute_network" "vpc_network" {
  name                    = "askvarchevski-vpc"
  description             = "my network"
  auto_create_subnetworks = "false"
  routing_mode            = "GLOBAL"
}

resource "google_compute_firewall" "external-allow" {
  name        = "askvarchevski-external"
  description = "Allow external 80 port"
  network     = "${google_compute_network.vpc_network.name}"

  allow {
    protocol = "tcp"
    ports    = ["80", "22"]
  }
  target_tags = ["http-server", "ssh"]
}

resource "google_compute_firewall" "allow-internal" {
  name    = "askvarchevski-internal"
  network = "${google_compute_network.vpc_network.name}"
  
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

resource "google_compute_subnetwork" "subnetpriv" {
  name          = "asvarchevski-private"
  ip_cidr_range = "10.11.2.0/24"
  region        = "us-central1"
  network       = "${google_compute_network.vpc_network.name}"
  description = "private subnetwork"
}

resource "google_compute_subnetwork" "subnetpub" {
  name          = "askvarchevski-public"
  ip_cidr_range = "10.11.1.0/24"
  region        = "us-central1"
  network       = "${google_compute_network.vpc_network.name}"
  description   = "public subnetwork"
}