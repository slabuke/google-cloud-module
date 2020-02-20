resource "google_compute_firewall" "firewall-public" {
  name = "${var.firewall}-public"
  network = "${google_compute_network.networks.self_link}"
  target_tags = ["http"]

  allow {
    protocol = "tcp"
    ports = ["80"]
        }

  depends_on = ["google_compute_subnetwork.public_subnetwork"]

}

resource "google_compute_firewall" "ssh-external" {
  name = "ssh-external"
  network = "${google_compute_network.networks.self_link}"
  target_tags = ["ssh"]
 
  allow {
    protocol = "tcp"
    ports = ["22"]
        }

}

resource "google_compute_firewall" "ssh-internal" {
  name = "ssh-open"
  network = "${google_compute_network.networks.self_link}"
  target_tags = ["ssh-internal"]
  source_ranges = ["${var.ip1}"]

  allow {
    protocol = "tcp"
    ports = ["22"]
        }

}

resource "google_compute_firewall" "open_ports" {
  name = "open-ports"
  network = "${google_compute_network.networks.self_link}"
  target_tags = ["open"] 
  source_ranges = ["${var.ip1}", "${var.ip2}"]

  allow {
    protocol = "tcp"
    ports = ["5432"]
        }

}

output "google_compute_firewall_ssh_name" {
  value = "${google_compute_firewall.ssh-external.self_link}"
}
