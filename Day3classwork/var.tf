variable "node_count" {
  default = "2"
 }

variable "project" {
	default = "artsemiyoursh-day1proj"
}

variable "region" {
	default = "us-central1"
}

variable "vm-name" {
	default = "nginx-classwork-terraform"

}

variable "zone" {
	default = "us-central1-a"
}

variable "network" {
	default = "default"
}

variable "machine" {
	default = "g1-small"
}

variable "protection" {
	default = "true"
}

variable "lab-servertype" {
	default = "nginxserver"
}

variable "lab-osfamily" {
	default = "ubuntu"
}

variable "lab-wayofinstallation" {
	default = "terraform"
}

variable "disktype" {
	default = "pd-ssd"
}

variable "image" {
	default = "ubuntu-os-cloud/ubuntu-1604-lts"
}

variable "disksize" {
	default = "30"
}

variable "script" {
	default = "#!/bin/bash \nsudo apt-get -y update \nsudo apt-get -y install nginx \nsystemctl start nginx \nsystemctl enable nginx"
}

variable "delete" {
	default = "40m"
}

