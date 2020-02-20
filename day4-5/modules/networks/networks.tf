resource "google_compute_network" "networks" {
  name = "${var.student_name}-vpc"
  auto_create_subnetworks = false
}
