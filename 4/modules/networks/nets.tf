#---------------------NET-------------------------

resource "google_compute_network" "dmitriy-mv" {
  name                    = "${var.network_name}"
  description             = "Main NET"
  auto_create_subnetworks = false
}

output "network_name" {
  value = "${google_compute_network.dmitriy-mv.name}"
}
