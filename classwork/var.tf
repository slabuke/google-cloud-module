variable "name" {
  default     = "nginx-classwork-terraform"
  description = "Ubuntu based nginx server"
}

variable "instance_count" {
  default = "2"
}

variable "SSDsize" {
  default = "30"
}

variable "Image_source" {
  default = "ubuntu-1604-xenial-v20200129"
}

variable "Instance_type" {
  default = "g1-small"
}

variable "Zone" {
  default = "us-central1-a"
}
