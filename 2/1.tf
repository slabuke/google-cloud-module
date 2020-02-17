provider "google" {
  credentials = "${file(".instant-river-268209-57e284821158.json")}"
  project     = "instant-river-268209"
  region      = "us-central1"
  zone        = "us-central1-c"
}

resource "google_compute_instance" "nginx-terraform" {
  name                    = "${var.Name}"
  zone                    = "${var.Zone}"
  machine_type            = "${var.MT}"
  tags                    = ["http-server", "https-server"]
  metadata_startup_script = "sudo yum update -y \n sudo yum install nginx -y \n sudo systemctl restart nginx \n sudo systemctl enable nginx"
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
    osfamily          = "redhat"
    wayofinstallation = "terraform"
  }
}

resource "google_compute_disk" "nginx-gcp-tf" {
  name                      = "nginx-gcp-tf"
  zone                      = "${var.Zone}"
  size                      = "10"
  labels                    = {}
  physical_block_size_bytes = 4096
}

resource "google_compute_attached_disk" "default" {
  disk     = "${google_compute_disk.nginx-gcp-tf.self_link}"
  instance = "${google_compute_instance.nginx-terraform.self_link}"
}
