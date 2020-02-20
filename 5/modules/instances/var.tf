variable "name" {
  default     = "nginx-terraform"
  description = "Ubuntu based nginx server"
}

variable "name2" {
  default     = "bastion-terraform"
  description = "Ubuntu based server"
}

variable "instance_count" {
  default = "1"
}

variable "SSDsize" {
  default = "20"
}

variable "Image_source" {
  default = "ubuntu-1604-xenial-v20200129"
}

variable "Instance_type" {
  default = "g1-small"
}

variable "WebZone" {
  default     = "us-central1-b"
  description = "Zone for nginxserver"
}

variable "BastionZone" {
  default     = "us-central1-a"
  description = "Zone for Bastion server"
}
#networking:
variable "Subnet-1-name" {}
variable "Subnet-2-name" {}
variable "network_name" {}
variable "google_compute_firewall_ssh_name" {}
