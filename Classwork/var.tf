variable "project" {
	default = "vnikiforov-day1"
}

variable "region" {
	default = "us-central1"
}

variable "ipv4" {
	default = "ipv4-address"
}

variable "name" {
	default = "nginx-terraform-attached"
}

variable "zone" {
	default = "us-central1-c"
}

variable "network" {
	default = "default"
}

variable "mt" {
	default = "custom-1-4608"
}

variable "protection" {
	default = "true"
}

variable "srv" {
	default = "nginxserver"
}

variable "os" {
	default = "redhat"
}
variable "way" {
	default = "gcloud"
}
variable "disk" {
	default = "pd-ssd"
}
variable "image" {
	default = "centos-cloud/centos-7"
}
variable "size" {
	default = "35"
}
variable "script" {
	default = "#!/bin/bash\nyum update -y\nyum install epel-release -y\nyum install nginx -y\nsystemctl start nginx\nsystemctl enable nginx\n"
}
variable "gcdname" {
	default = "terraf-disk-1"
}
variable "gcdtype" {
	default = "pd-standard"
}
variable "gcdzone" {
	default = "us-central1-c"
}
variable "gcdsize" {
	default = "200"
}


