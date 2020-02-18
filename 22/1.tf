provider "google" {
  credentials = "${file(".instant-river-268209-57e284821158.json")}"
  project     = "instant-river-268209"
  region      = "us-central1"
  zone        = "us-central1-a"
}

resource "google_compute_instance" "nginx-classwork-terraform" {
  count                   = "${var.ins_count}"
  name                    = "${var.Name}-${count.index}"
  zone                    = "${var.Zone}"
  machine_type            = "${var.MT}"
  tags                    = ["http-server", "https-server"]
  metadata_startup_script = "sudo apt-get update -y \n sudo apt-get install nginx -y \n sudo systemctl restart nginx \n sudo systemctl enable nginx"
  deletion_protection     = "true"

  boot_disk {
    initialize_params {
      size  = "${var.ssd_size}"
      type  = "${var.DiskType}"
      image = "${var.IM}"
    }
  }

  network_interface {
    network       = "default"
    subnetwork    = "default"
    access_config = {}
  }

  labels {
    servertype        = "nginxserver"
    osfamily          = "debian"
    wayofinstallation = "terraform"
  }

  timeouts {
    delete = "40m"
  }
}
