#------------------------name-----------------------
variable "name" {
  default     = "nginx-terraform"
  description = "Ubuntu nginx server"
}

#------------------------bastion-----------------------
variable "bast" {
  default     = "bastion-terraform"
  description = "Ubuntu server"
}

#-----------------------------------------------
variable "SSDsize" {
  default = "20"
}

#-----------------------------------------------
variable "Image_source" {
  default = "ubuntu-1604-xenial-v20200129"
}

#-----------------------------------------------
variable "Instance_type" {
  default = "g1-small"
}

#-----------------------------------------------
variable "BastionZone" {
  default     = "us-central1-a"
  description = "Zone for bastion"
}

#-----outer vars

variable "Subnet_1" {}
variable "Subnet_2" {}
variable "network_name" {}
variable "google_compute_firewall_ssh_name" {}
