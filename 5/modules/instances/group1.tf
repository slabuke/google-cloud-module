resource "google_compute_region_instance_group_manager" "public_group" {
  name                      = "instance-group-public-manager"
  target_size               = "1"
  distribution_policy_zones = ["us-central1-a", "us-central1-b", "us-central1-c"]
  base_instance_name        = "webserver"
  region                    = "us-central1"

  instance_template = "${google_compute_instance_template.nginxserver.self_link}"
  target_pools      = ["${google_compute_target_pool.web-lb.self_link}"]
}

output "public_managed_group" {
  value = "${google_compute_region_instance_group_manager.public_group.instance_group}"
}

output "public_managed_group_link" {
  value = "${google_compute_region_instance_group_manager.public_group.self_link}"
}

resource "google_compute_target_pool" "web-lb" {
  name = "web-lb"
}

resource "google_compute_instance_template" "nginxserver" {
  name        = "webserver-template"
  description = "This template is used to create web server instances."
  tags        = ["http", "ssh-int"]

  labels = {
    environment = "test"
  }

  instance_description = "Webservers group template"
  machine_type         = "n1-standard-1"
  can_ip_forward       = true

  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
  }

  # Create a new boot disk from an image
  disk {
    source_image = "debian-cloud/debian-9"
    auto_delete  = true
    boot         = true
  }

  network_interface {
    network       = "${var.network_name}"
    subnetwork    = "${var.Subnet-1-name}"
    access_config = {}
  }

  metadata_startup_script = <<EOF
sudo -i
apt-get -y update
apt-get -y install nginx
systemctl start nginx
systemctl enable nginx
echo 'Hello from Andrei Batura!' > /var/www/html/index.html
EOF
}
