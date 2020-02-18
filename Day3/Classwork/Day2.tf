variable "instance_count" {
}

variable "instance_name" {
}

variable "region" {
}

variable "zone" {
}

variable "machine_type" {
}

variable "image_family" {
}

variable "image_project" {
}

variable "disk_type" {
}

variable "disk_size_gb" {
}

variable "label1" {
}

variable "label2" {
}

variable "label3" {
}

variable "http" {
}

variable "https" {
}

provider "google" {
  credentials = "${file("terraform-admin.json")}"
  project     = "gothic-isotope-268209"
  region      = "us-central1"
}

resource "google_compute_instance" "nginx-terraform" {
  count        = "${var.instance_count}"
  name         = "${var.instance_name}-${count.index}"
  machine_type = "${var.machine_type}"
  zone         = "${var.zone}"
  tags 	       = ["${var.http}","${var.https}"]
  description  = "Simple machine"

 boot_disk {
   initialize_params {
	image = "${var.image_project}/${var.image_family}"
	size  = "${var.disk_size_gb}"
	type  = "${var.disk_type}"
   }
 }


 timeouts {
	delete = "20m"
}


deletion_protection = 1

labels = {
    servertype = "${var.label1}"
    osfamily = "${var.label2}"
    wayofinstallation = "${var.label3}"
  }

 metadata_startup_script = "sudo yum -y update; sudo yum -y install nginx; systemctl enable nginx; systemctl start nginx"

 network_interface {
   network = "default"

   access_config {

   }
 }
}

