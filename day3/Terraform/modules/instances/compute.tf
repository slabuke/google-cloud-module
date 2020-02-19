# Revise variables.tf for vars

data "google_compute_zones" "available" {}

resource "google_compute_instance" "nginx-web" {
  name = "nginx-${var.Name}"  
	description = "Nginx sample VM"
  deletion_protection = false
  project = "${var.Project}"
  zone = "${var.Zone}"
  machine_type = "${var.Type}"
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
    wayofinstallation = "${var.LabelWay}"
	}

  network_interface {
    network = "${var.student_name}-vpc"
    subnetwork = "sub-${var.student_name}-public"
    access_config = {}
  }

	# lifecycle { prevent_destroy = true }

}

resource "google_compute_address" "bastion-ip-address" {
  name = "bastion-ip"
}

resource "google_compute_instance" "bastion-srv" {
  name = "bastion-${var.Name}"  
  description = "Nginx sample VM"
  deletion_protection = false
  project = "${var.Project}"
  zone = "${var.ZoneBastion}"
  machine_type = "${var.Type}"
  tags  =  "${var.TagsBastion}"

  boot_disk {
    initialize_params {
      image = "${var.DiskImage}"
      type = "${var.DiskType}"
      size = "${var.DiskSize}"
    }
  }

  metadata_startup_script = "${var.ProvisionBastion}"

  labels {
    servertype = "${var.LabelSTB}"
    osfamily = "${var.LabelOF}"
    wayofinstallation = "${var.LabelWay}"
  }

  network_interface {
    network = "${var.student_name}-vpc"
    subnetwork = "sub-${var.student_name}-public"
    access_config = {
      nat_ip = "${google_compute_address.bastion-ip-address.address}"
    }
  }

  # lifecycle { prevent_destroy = true }

}

module "gce-lb-http" {
  version           = "1.0.10"
  source            = "GoogleCloudPlatform/lb-http/google"
  name              = "group-http-lb"
  target_tags       = ["web"]
  backends          = {
    "0" = [
      { group = "${google_compute_instance_group.nginx-group.self_link}" }
    ],
  }
  backend_params = ["/,http,80,10"]
}

resource "google_compute_instance_group" "nginx-group" {
  name = "nginx-group"
  zone = "${var.Zone}"
  # region = "${var.Region}"
  description = "Group of 1 nginx server"
   instances = ["${google_compute_instance.nginx-web.self_link}"]
}

# data "google_compute_region_instance_group" "nginx-group" {
#   name = "nginx-group"
#   region = "us-central1"
# }

# resource "google_compute_region_instance_group_manager" "igm" {
#   name = "nginx-group"
#   target_size = "1"
#   base_instance_name = "nginx-web"
#   region = "us-central1"
#   instance_template  = "${google_compute_instance_template.nginx-web.self_link}"
# }