variable "bastion_name" {
  default     = "bastion"
  description = "Bastion Server"
}

variable "instance_count" {
  default = "1"
}

variable "size" {
  default = "20"
}

variable "Image_source" {
  default = "ubuntu-1604-xenial-v20200129"
}

variable "Instance_type" {
  default = "g1-small"
}

variable "bastion-zone" {
  default     = "us-central1-a"
  description = "Zone for Bastion server"
}

variable "Subnet-1-name" {}
variable "Subnet-2-name" {}
variable "vpc_name" {}
variable "google_compute_firewall_ssh_name" {}
