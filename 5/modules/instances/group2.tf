resource "google_compute_target_pool" "db-lb" {
  name = "db-lb"
}

resource "google_compute_region_instance_group_manager" "private_group" {
  name                      = "instance-group-private-manager"
  distribution_policy_zones = ["us-central1-a", "us-central1-b", "us-central1-c"]
  target_size               = "3"
  base_instance_name        = "dbserver"
  region                    = "us-central1"
  instance_template         = "${google_compute_instance_template.db.self_link}"
  target_pools              = ["${google_compute_target_pool.db-lb.self_link}"]
}

output "private_managed_group" {
  value = "${google_compute_region_instance_group_manager.private_group.instance_group}"
}

output "private_managed_group_link" {
  value = "${google_compute_region_instance_group_manager.private_group.self_link}"
}

resource "google_compute_instance_template" "db" {
  name        = "db-template"
  description = "This template is used to create db server instances."
  tags        = ["db", "ssh-int"]

  labels = {
    environment = "dbserver"
  }

  instance_description = "dbservers group template"
  machine_type         = "g1-small"
  can_ip_forward       = true

  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
  }

  // Create a new boot disk from an image
  disk {
    source_image = "debian-cloud/debian-9"
    auto_delete  = true
    boot         = true
  }

  network_interface {
    network    = "${var.network_name}"
    subnetwork = "${var.Subnet-2-name}"
  }
}
