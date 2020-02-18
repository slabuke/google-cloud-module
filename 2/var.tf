variable "name" {
  default = "nginx-classwork-terraform"
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
