#===================Create Bastion========================

resource "google_compute_instance" "bastion" {
  name         = "${var.bastion_name}"
  machine_type = "${var.Instance_type}"
  zone         = "${var.bastion-zone}"
  tags         = ["ssh", "ssh-server"]

  metadata_startup_script = <<EOF
sudo -i
apt-get -y update
EOF

  boot_disk {
    initialize_params {
      type  = "pd-ssd"
      size  = "${var.size}"
      image = "${var.Image_source}"
    }
  }

  network_interface {
    network       = "${var.vpc_name}"
    subnetwork    = "${var.Subnet-1-name}"
    access_config = {}
  }

  labels = {
    servertype        = "bastionserver"
    osfamily          = "debian"
    wayofinstallation = "terraform"
  }
}
