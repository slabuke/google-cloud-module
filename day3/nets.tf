resource "google_compute_network" "maxim-vpc" {
  name = "${var.student_name}-vpc"
  auto_create_subnetworks = "false"
  routing_mode = "GLOBAL"
  description = "Public vpc network for project"
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
  description = "open http trafiic to internal resource"
allow {
    protocol = "tcp"
    ports    = ["80"]
  }
  target_tags = ["${var.tag[0]}"] 
}
resource "google_compute_firewall" "ssh-open" {
  name    = "ssh-open"
  network = "${google_compute_network.maxim-vpc.name}"
  description = "open ssh trafiic to internal resource"
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  target_tags = ["${var.tag[2]}"]
}


