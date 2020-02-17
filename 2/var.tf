variable "name" {
  default = "nginx-terraform"
}

variable "SSDsize" {
  default = "25"
}

variable "Image_source" {
  default = "centos-7-v20200205"
}

variable "Instance_type" {
  default = "custom-1-4608"
}

variable "Zone" {
  default = "us-central1-c"
}
