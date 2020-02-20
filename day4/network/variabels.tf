variable "project" {
  default = "my-epamlab0001-project"
}

variable "region" {
  default  = ["us-central1"]
}

variable "tag" {
  default = ["http-server", "https-server", "ssh", "telnet"]
}

variable "public-ip_cidr_range" {
  default     = "10.7.1.0/24"
  description = "public IP range related to ID"
}

variable "private-ip_cidr_range" {
  default     = "10.7.2.0/24"
  description = "private IP range related to ID"
}