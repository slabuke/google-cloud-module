resource "google_compute_instance" "bastion-terraform" {
  name         = "${var.name2}"
  machine_type = "${var.Instance_type}"
  zone         = "${var.BastionZone}"
  tags         = ["ssh", "ssh-server"]

  metadata_startup_script = <<EOF
sudo -i
apt-get -y update
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
    servertype        = "bastionserver"
    osfamily          = "debian"
    wayofinstallation = "terraform"
  }
}
