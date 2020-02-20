variable "firewall" {
  default = "firewall"
}

variable "student_name" {
  default = "brytsikava"
}

variable "region" {
  default = "us-central1"
}

variable "ip1" {
  default = "10.15.1.0/24"
}

variable "ip2" {
  default = "10.15.2.0/24"
}

variable "bastion_tags" {
  default = ["ssh", "ssh-server"]
}