#==========================VPC==================

resource "google_compute_network" "andrei-leanovich-vpc" {
  name                    = "${var.vpc_name}"
  auto_create_subnetworks = false
}

#=======================Subnet====================

resource "google_compute_subnetwork" "Subnet-1" {
  name          = "${var.subnet-1-name}"
  region        = "${var.region}"
  network       = "${google_compute_network.andrei-leanovich-vpc.self_link}"
  description   = "Public range"
  ip_cidr_range = "${var.cidr-block-1}"
}

resource "google_compute_subnetwork" "Subnet-2" {
  name          = "${var.subnet-2-name}"
  region        = "${var.region}"
  network       = "${google_compute_network.andrei-leanovich-vpc.self_link}"
  description   = "Private range"
  ip_cidr_range = "${var.cidr-block-2}"
}

#=====================Firewall========================

resource "google_compute_firewall" "egress-firewall" {
  name        = "egress-firewall"
  network     = "${var.vpc_name}"
  description = "Private Firewall rules"

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }

  direction = "EGRESS"
}

resource "google_compute_firewall" "ingress-firewall" {
  name        = "ingress-firewall"
  network     = "${var.vpc_name}"
  description = "Public Firewall rules"

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["22", "80"]
  }
}

#========================Instance======================

resource "google_compute_instance" "terraform" {
  count = "${length(var.name)}"

  name                = "web-server-${count.index + 1}"
  machine_type        = "custom-${var.cpu}-${var.ram}"
  zone                = "${var.zone}"
  deletion_protection = false

  labels = {
    server-type       = "nginx-server"
    osfamily          = "debian"
    wayofinstallation = "terraform"
  }

  timeouts {
    delete = "40m"
  }

  tags = ["http-server", "https-server"]

  boot_disk {
    initialize_params {
      size  = "${var.disk_size_gb}"
      image = "ubuntu-1604-xenial-v20200129"
      type  = "pd-ssd"
    }
  }

  scratch_disk {
    interface = "SCSI"
  }

  network_interface {
    network       = "${var.vpc_name}"
    subnetwork    = "${var.subnet-1-name}"
    access_config = {}
  }

  metadata = {
    userdata = "${file("script.sh")}"
  }

  #metadata_startup_script = "${var.nginx}"
}
