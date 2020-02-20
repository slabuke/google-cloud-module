#networking:
variable "Subnet-1-name" {
  type    = "string"
  default = "public"
}

variable "Subnet-2-name" {
  type    = "string"
  default = "private"
}

variable "vpc_name" {
  type    = "string"
  default = "andrei-leanovich-vpc"
}

variable "region" {
  default = "us-central1"
}

variable "cidr-block-1" {
  default = "10.1.1.0/24"
}

variable "cidr-block-2" {
  default = "10.1.2.0/24"
}
