resource "google_compute_network" "vpc_network" {
  name                    = "vandrushkevich-vpc"
  description             = "my network"
  auto_create_subnetworks = "false"
  routing_mode            = "GLOBAL"
}

resource "google_compute_firewall" "external-allow" {
  name        = "vandrushkevich-external"
  description = "Allow external 80 port"
  network     = "${google_compute_network.vpc_network.name}"

  allow {
    protocol = "tcp"
    ports    = ["80", "22"]
  }
  target_tags = ["http-server", "ssh"]
}

resource "google_compute_firewall" "allow-internal" {
  name    = "vandrushekvich-internal"
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
  name          = "vandrushkevich-private"
  ip_cidr_range = "10.14.2.0/24"
  region        = "us-central1"
  network       = "${google_compute_network.vpc_network.name}"
  description = "private subnetwork"
}

resource "google_compute_subnetwork" "subnetpub" {
  name          = "vandrushkevich-public"
  ip_cidr_range = "10.14.1.0/24"
  region        = "us-central1"
  network       = "${google_compute_network.vpc_network.name}"
  description   = "public subnetwork"
}
