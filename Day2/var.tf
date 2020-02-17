variable "project" {
	default = "artsemiyoursh-day1proj"
}

variable "region" {
	default = "us-central1"
}

variable "vm-name" {
	default = "nginx-terraform"
}

variable "zone" {
	default = "us-central1-c"
}

variable "network" {
	default = "default"
}

variable "memory" {
	default = "custom-1-4608"
}

variable "protection" {
	default = "true"
}

variable "lab-servertype" {
	default = "nginxserver"
}

variable "lab-osfamily" {
	default = "redhat"
}

variable "lab-wayofinstallation" {
	default = "terraform"
}

variable "disktype" {
	default = "pd-ssd"
}

variable "image" {
	default = "centos-cloud/centos-7"
}

variable "disksize" {
	default = "35"
}

variable "script" {
	default = "#!/bin/bash \nyum update -y \nyum install epel-release -y \nyum install nginx -y \nsystemctl start nginx \nsystemctl enable nginx"
}

variable "attdiskname" {
	default = "nginx-terraform-2"
}
variable "attdisktype" {
	default = "pd-standard"
}
variable "attdisksize" {
	default = "200"
}

