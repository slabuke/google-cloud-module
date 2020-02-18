resource "google_compute_network" "vpc_network" {
  name = "${var.student_name}-vpc"
  auto_create_subnetworks = "false"
  description = "test public vpc network"
  routing_mode = "GLOBAL"
}


resource "google_compute_subnetwork" "subnetpriv" {
  name          = "private-subnetwork"
  ip_cidr_range = "10.4.2.0/24"
  region        = "us-central1"
  network       = "${google_compute_network.vpc_network.name}"
  description = "private subnetwork"
}

resource "google_compute_subnetwork" "subnetpub" {
  name          = "public-subnetwork"
  ip_cidr_range = "10.4.1.0/24"
  region        = "us-central1"
  network       = "${google_compute_network.vpc_network.name}"
  description = "public subnetwork"
}

resource "google_compute_firewall" "allow-internal" {
  name    = "allowint"
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

resource "google_compute_firewall" "allow-http" {
  name    = "allowhttp"
  network = "${google_compute_network.vpc_network.name}"
allow {
    protocol = "tcp"
    ports    = ["80"]
  }
  target_tags = ["http-server"] 
}
resource "google_compute_firewall" "allow-ssh" {
  name    = "allowssh"
  network = "${google_compute_network.vpc_network.name}"
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  target_tags = ["ssh"]
}