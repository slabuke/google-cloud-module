/*resource "google_compute_instance_group" "instance_group_public" {
  name        = "instance-group-public"
  description = "Terraform unmanaged public subnet group"

  zone = "us-central1-b"

  instances = [
    "${google_compute_instance.nginx-terraform.self_link}",
  ]
}*/
#resource "google_compute_instance_group" "instance_group_public" {
#  name        = "instance-group-public"
#  description = "Terraform unmanaged public subnet group"
#
#}

resource "google_compute_region_instance_group_manager" "public_group" {
  name               = "instance-group-public-manager"
  target_size        = "1"
  base_instance_name = "webserver"
  region             = "us-central1"

  #zone               = ["us-central1-b", "us-central1-c", "us-central1-a"]
  instance_template = "${google_compute_instance_template.nginxserver.self_link}"
}

resource "google_compute_instance_template" "nginxserver" {
  name        = "webserver-template"
  description = "This template is used to create web server instances."
  tags        = ["http", "ssh"]

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

  // Create a new boot disk from an image
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
echo 'Hello from Dmitriy!' > /var/www/html/index.html
EOF
}

data "google_compute_image" "my_image" {
  family  = "debian-9"
  project = "debian-cloud"
}
