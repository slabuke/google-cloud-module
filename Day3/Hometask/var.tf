variable "instance_name" {
	default = "nginx-terraform"
}

variable "region" {
	default = "us-central1"
}

variable "zone" {
	default = "us-central1-a"
}


variable "machine_type" {
	default = "custom-1-1792"
}

variable "image_family" {
	default = "ubuntu-1804-lts"
}

variable "image_project" {
	default = "ubuntu-os-cloud"
}

variable "disk_type" {
	default = "pd-ssd"
}

variable "disk_size_gb" {
	default = 30
}


variable "http" {
	default = "http-server"
}

variable "https" {
	default = "https-server"
}

variable "network_name" {
  type        = "string"
  default     = "pavel-vpc"
}

variable "network-region" {
  default     = "us-central1"
}

variable "net1" {
  type        = "string"
  default     = "public"
}

variable "net2" {
  type        = "string"
  default     = "private"
}

variable "range1" {
  default     = "10.3.1.0/24"
}

variable "range2" {
  default     = "10.3.2.0/24"
}
