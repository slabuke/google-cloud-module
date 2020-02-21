# Create bastion-host
resource "google_compute_instance" "bastion" {
  name         = "${var.name2}"
  machine_type = "${var.instance_typece}"
  zone         = "us-central1-a"
  tags         = ["ssh", "ssh-server"]

  boot_disk {
    initialize_params {
      type  = "pd-ssd"
      size  = "${var.disk_size}"
      image = "${var.image_source}"
    }
  }

  network_interface {
    network       = "${var.network_name}"
    subnetwork    = "${var.subnet-1-name}"
    access_config = {}
  }

  labels = {
    servertype        = "bastionhost"
    osfamily          = "debian"
    wayofinstallation = "terraform"
  }

  metadata_startup_script = <<EOF
sudo -i
apt-get -y update
EOF
}
