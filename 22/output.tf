output "http" {
  value = "http://${google_compute_instance.nginx-classwork-terraform.network_interface.0.access_config.0.nat_ip}"
}

variable "Name" {
  default     = "nginx-classwork-terraform"
  description = "Ubuntu nginxserver"
}

variable "ins_count" {
  default = "2"
}

variable "ssd_size" {
  default = "30"
}

variable "MT" {
  default = "g1-small"
}

variable "IM" {
  default = "ubuntu-1604-xenial-v20200129"
}

variable "DiskType" {
  default = "pd-ssd"
}

variable "Zone" {
  default = "us-central1-a"
}
