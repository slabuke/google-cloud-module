#----------------------------------web lb---------------------------
resource "google_compute_target_pool" "web-lb" {
  name = "web-lb"
}

output "public_managed_group" {
  value = "${google_compute_region_instance_group_manager.public_group.instance_group}"
}

#----------------------------------instance-group-public-manager---------------------------
resource "google_compute_region_instance_group_manager" "public_group" {
  name               = "instance-group-public-manager"
  target_size        = "1"
  base_instance_name = "webserver"
  region             = "us-central1"
  instance_template  = "${google_compute_instance_template.nginxserver.self_link}"
  target_pools       = ["${google_compute_target_pool.web-lb.self_link}"]
}

#----------------------------------webserv template---------------------------
resource "google_compute_instance_template" "nginxserver" {
  name        = "webserver-template"
  description = "Template for web servers"
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
    subnetwork    = "${var.Subnet_1}"
    access_config = {}
  }

  metadata_startup_script = <<EOF
sudo -i
apt-get -y update
apt-get -y install nginx
systemctl start nginx
systemctl enable nginx
echo 'Hello from Dmitriy Shishkovets!' > /var/www/html/index.html
EOF
}

#-------------------bucket storage---------------------------
resource "google_storage_bucket" "image-store" {
  name = "dmitriys-bucket"

  website {
    main_page_suffix = "index.html"
    not_found_page   = "404.html"
  }
}
