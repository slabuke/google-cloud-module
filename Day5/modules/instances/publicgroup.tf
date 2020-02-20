#======================Create public instance group====================

resource "google_compute_target_pool" "web-lb" {
  name = "web-lb"
}

resource "google_compute_region_instance_group_manager" "public_group" {
  name               = "instance-group-public-manager"
  target_size        = "1"
  base_instance_name = "webserver"
  region             = "us-central1"

  instance_template = "${google_compute_instance_template.web-server.self_link}"
  target_pools      = ["${google_compute_target_pool.web-lb.self_link}"]
}

output "public_managed_group_link" {
  value = "${google_compute_region_instance_group_manager.public_group.self_link}"
}

output "public_managed_group" {
  value = "${google_compute_region_instance_group_manager.public_group.instance_group}"
}

#=========================Create web-server============================

resource "google_compute_instance_template" "web-server" {
  name        = "webserver-template"
  description = "This template is used to create web server instances."
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
    network       = "${var.vpc_name}"
    subnetwork    = "${var.Subnet-1-name}"
    access_config = {}
  }

  metadata_startup_script = <<SCRIPT
 sudo yum update -y
 sudo yum install nginx -y
 sudo echo "<h1>Hello from Andrei Leanovich!</h1>" > /usr/share/nginx/html/index.html
 sudo systemctl enable nginx
 sudo systemctl start nginx
SCRIPT
}
