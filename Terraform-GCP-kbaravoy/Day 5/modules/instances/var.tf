# variables for instances module

variable "name" {
  default     = "nginx-host"
}

variable "name2" {
  default     = "bastion-host"
}

variable "instance_count" {
  default = "1"
}

variable "disk_size" {
  default = "30"
}

variable "image_source" {
  default = "debian-9-stretch-v20200210"
}

variable "instance_typece" {
  default = "g1-small"
}

#For networking via output:
variable "subnet-1-name" {}
variable "subnet-2-name" {}
variable "network_name" {}
variable "google_compute_firewall_ssh_name" {}
