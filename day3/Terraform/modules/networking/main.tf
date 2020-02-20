# Revise vars.tf for vars

resource "google_compute_subnetwork" "public-sub" {
  name          = "sub-${var.student_name}-public"
  description = "Public subnetwork for Task5"
  ip_cidr_range = "10.8.1.0/24"
  region        = "us-central1"
  network       = "${google_compute_network.vpc_network.self_link}"
}

resource "google_compute_subnetwork" "private-sub" {
  name          = "sub-${var.student_name}-private"
  description = "Private subnetwork for Task5"
  ip_cidr_range = "10.8.2.0/24"
  region        = "us-central1"
  network       = "${google_compute_network.vpc_network.self_link}"
}

resource "google_compute_network" "vpc_network" {
  name = "${var.student_name}-vpc"
  description = "VPC network for Task5"
  auto_create_subnetworks = false
}