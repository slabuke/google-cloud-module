output "http" {
  value = "http://${google_compute_instance.nginx-gcp-terraform.network_interface.0.access_config.0.nat_ip}"
}

variable "project" {
  type = "string"
  description = "Set name of project"
  default = "glassy-hue-268209"
}

variable "region" {
  type = "string"
  description = "Set region"
  default = "us-central1"
}

variable "zone" {
  type = "string"
  description = "Set zone"
  default = "us-central1-c"
}

variable "name" {
  type = "string"
  description = "Set the name of instance"
  default = "nginx-gcp-terraform"
}

variable "deletion"{
  default = true
}

variable "type" {
  type = "string"
  description = "1CPU with 4.5 Gb RAM"
  default = "custom-1-4608"
}

variable "disk_size" {
  description = "Size of our drive"
  default = "35"
}

variable "disk_type" {
  type = "string"
  description = "Type of disk"
  default = "pd-ssd"
}

variable "disk_image" {
  type = "string"
  description = "Type of disk image"
  default = "centos-7"
}

variable "tags" {
  type    = "list"
  default = ["http-server", "https-server"]
}

