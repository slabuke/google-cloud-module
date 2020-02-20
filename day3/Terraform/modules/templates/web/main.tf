# Revise vars.tf for vars

resource "google_compute_instance_template" "nginx-web" {
  name        = "nginx-web"
  tags = "${var.Tags}"
  project = "${var.Project}"
  labels = {
    environment = "dev"
  }
  machine_type         = "${var.Type}"
  can_ip_forward       = true
  disk {
    source_image = "${var.DiskImage}"
    auto_delete  = true
    boot         = true
  }
  network_interface {
  network = "${var.vpc-name}"
	subnetwork = "${var.sub-vpc-public-name}"
  access_config = {}
  }
  metadata_startup_script = "${var.Provision}"
}

data "google_compute_image" "my_image" {
  family  = "centos-7"
  project = "centos-cloud"
}
