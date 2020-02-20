/*resource "google_compute_instance" "nginx-terraform" {
  name         = "${var.name}"
  machine_type = "${var.Instance_type}"
  zone         = "${var.WebZone}"
  tags         = ["http-server", "https-server"]

  metadata_startup_script = <<EOF
sudo -i
apt-get -y update
apt-get -y install nginx
systemctl start nginx
systemctl enable nginx
echo 'Hello from dmitriy !' > /var/www/html/index.html
EOF

  boot_disk {
    initialize_params {
      type  = "pd-ssd"
      size  = "${var.SSDsize}"
      image = "${var.Image_source}"
    }
  }

  network_interface {
    network       = "${var.network_name}"
    subnetwork    = "${var.Subnet-1-name}"
    access_config = {}
  }

  labels = {
    servertype        = "nginxserver"
    osfamily          = "debian"
    wayofinstallation = "terraform"
  }
}

output "VM_IP" {
  value = "http://${google_compute_instance.nginx-terraform.network_interface.0.access_config.0.nat_ip }"
}

output "self_link" {
  value       = "${google_compute_instance.nginx-terraform.self_link}"
  description = "The URL of the created Web server"
}
*/

