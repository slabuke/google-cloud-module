# Create target pool for internal load-balancer
resource "google_compute_target_pool" "db-lb" {
  name = "db-lb"
}

# Create templates for deploy backend
resource "google_compute_instance_template" "db" {
  name = "db-template"
  tags = ["db", "ssh-int"]

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

  disk {
    source_image = "debian-cloud/debian-9"
    auto_delete  = true
    boot         = true
  }

  network_interface {
    network    = "${var.network_name}"
    subnetwork = "${var.subnet-2-name}"
  }
}

# Create private instances group for backend hosts from instances tempalte
resource "google_compute_region_instance_group_manager" "private_group" {
  name               = "instance-group-private-manager"
  target_size        = "3"
  base_instance_name = "dbserver"
  region             = "us-central1"

  distribution_policy_zones = ["us-central1-a", "us-central1-b", "us-central1-c"]

  instance_template = "${google_compute_instance_template.db.self_link}"
  target_pools      = ["${google_compute_target_pool.db-lb.self_link}"]
}

# Output for main.tf
output "private_managed_group" {
  value = "${google_compute_region_instance_group_manager.private_group.instance_group}"
}

output "private_managed_group_link" {
  value = "${google_compute_region_instance_group_manager.private_group.self_link}"
}
