# Create target for Global load-balancer
resource "google_compute_target_pool" "web-lb" {
  name = "web-lb"
}

# Create template for deploy Webservers
resource "google_compute_instance_template" "nginxserver" {
  name        = "webserver-template"
  tags        = ["http", "ssh-int"]

  labels = {
    environment = "webserver"
  }

  instance_description = "Webservers group template"
  machine_type         = "n1-standard-1"
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
    network       = "${var.network_name}"
    subnetwork    = "${var.subnet-1-name}"
    access_config = {}
  }

  metadata_startup_script = <<EOF
sudo -i
apt-get -y update
apt-get -y install nginx
systemctl start nginx
systemctl enable nginx
echo 'Hello from Kirill_Baravoy!' > /var/www/html/index.html
EOF
}

# Create public group instances from Webservers template
resource "google_compute_region_instance_group_manager" "public_group" {
  name               = "instance-group-public-manager"
  target_size        = "1"
  base_instance_name = "web-server"
  region             = "us-central1"

  distribution_policy_zones  = ["us-central1-a", "us-central1-b", "us-central1-c"]

  instance_template = "${google_compute_instance_template.nginxserver.self_link}"
  target_pools      = ["${google_compute_target_pool.web-lb.self_link}"]
}

# Output for main.tf
output "public_managed_group" {
  value = "${google_compute_region_instance_group_manager.public_group.instance_group}"
}
