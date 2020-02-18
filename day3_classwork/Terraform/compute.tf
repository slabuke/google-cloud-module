# Revise variables.tf for vars

# Task1

data "google_compute_zones" "available" {}

resource "google_compute_instance" "nginx-cw" {
	count = "${var.Count}"
  name  = "${var.Name}-${count.index + 1}"  
	description = "Nginx sample VM-${count.index + 1}"
  deletion_protection = true
  project  = "${var.Project}"
  zone  =  "${var.Zone}"
  machine_type  =  "${var.Type}"
  tags  =  "${var.Tags}"

  boot_disk {
    initialize_params {
      image = "${var.DiskImage}"
      type = "${var.DiskType}"
      size = "${var.DiskSize}"
    }
  }

  metadata_startup_script = "${var.Provision}"

  labels {
    servertype = "${var.LabelST}"
    osfamily = "${var.LabelOF}"
    wayofinstallation = "${var.LabelWay}"
	}

  network_interface {
    network       = "${var.Network}"
    subnetwork       = "${var.Network}"
    access_config = {}
  }

	timeouts { delete = "40m" }
	lifecycle { prevent_destroy = true }

}

# Output instance IP

output "InstanceIP" {
 	value = "${google_compute_instance.nginx-cw.*.network_interface.0.access_config.0.nat_ip}"
}
