resource "google_compute_instance" "network" {
  name         = "${var.name}"
  machine_type = "${var.machine_type}"
  zone         = "${var.zone}"

  boot_disk {
    initialize_params {
      image = "${var.image}"
      size  = "${var.size}"
      type  = "${var.type}"
    }
  }

  network_interface {
    network       = "${var.student_name}-vpc"
    subnetwork    = "${var.pb_subnet}"
    access_config = {}
  }

  metadata_startup_script = "${var.script}"

  tags = "${var.tags}"
}

resource "google_compute_network" "networks" {
  name                    = "${var.student_name}-vpc"
  auto_create_subnetworks = false
  description             = "network"
}

resource "google_compute_firewall" "firewalls_private" {
  name          = "${var.firewall}-private"
  network       = "${google_compute_network.networks.name}"
  description   = "private firewall params"
  source_ranges = ["10.12.1.0/24"]

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }
}

resource "google_compute_firewall" "firewalls_public" {
  name        = "${var.firewall}-public"
  network     = "${google_compute_network.networks.name}"
  description = "public firewall params"

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["80", "22"]
  }
}

resource "google_compute_subnetwork" "public_subnetwork" {
  name          = "${var.pb_subnet}"
  region        = "${var.region}"
  network       = "${google_compute_network.networks.self_link}"
  ip_cidr_range = "${var.ip1}"
  description   = "pugblic params"
}

resource "google_compute_subnetwork" "private_subnetwork" {
  name          = "${var.pr_subnet}"
  region        = "${var.region}"
  network       = "${google_compute_network.networks.self_link}"
  ip_cidr_range = "${var.ip2}"
  description   = "private params"
}
