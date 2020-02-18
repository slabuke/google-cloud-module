variable "region" {
  description = "Region"
  default = "us-central1"
}

variable "project" {
  description = "Project"
  default = "macro-incline-268208"
}

variable "vm_name" {
  description = "Instance Name"
  default = "nginx-classwork-terraform"
}

variable "instance_count" {
default = 2
}

variable "zone" {
  description = "GCP Region"
  default     = "us-central1-a"
}

variable "disk_size" {
  description = "Disk Size"
  default = "30"
}

variable "disk_type" {
  description = "Disk Type"
  default = "pd-ssd"
}

variable "image" {
  description = "Image to use"
  default = "ubuntu-minimal-1604-xenial-v20200129"
}

variable "machine_type" {
  description = "Custom CPU and RAM"
  default = "custom-1-1792"
}

variable "script" {
  description = "Startup Script"
  default = "#!/bin/bash\nyum update\nyum install -y nginx\nsudo systemctl start nginx\nsudo systemctl enable nginx\n"
}

variable "network" {
  description = "Network Interface"
  default = "default"
}

variable "protection" {
  description = "Deletion Protection is On"
  default = true
}

variable "tags" {
  description = "HTTP/HTTPS Access"
  default = ["http-server", "https-server"]
}

variable "label_type" {
  description = "Label for ServerType"
  default = "nginxserver"
}

variable "label_os" {
  description = "Label for OSFamily"
  default = "debian"
}

variable "label_way" {
  description = "Label for WayOfInstallation"
  default = "terraform"
}

variable "description" {
  description = "Description"
  default = "Classwork VM"
}

