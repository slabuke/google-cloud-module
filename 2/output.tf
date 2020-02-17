output "http" {
  value = "http://${google_compute_instance.nginx-terraform.network_interface.0.access_config.0.nat_ip}"
}

variable "Name" {
  default = "nginx-terraform"
}

variable "ssd_size" {
  default = "25"
}

variable "MT" {
  default = "custom-1-4608"
}

variable "IM" {
  default = "centos-7"
}

variable "DiskType" {
  default = "pd-ssd"
}

variable "Zone" {
  default = "us-central1-c"
}

//gcloud compute instances attach-disk nginx-terraform --disk mydisk --zone us-central1-c

