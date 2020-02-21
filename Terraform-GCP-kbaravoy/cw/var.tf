variable "instance_count" {
  default = "2"
}

variable "Project_name" {
  default = "dev-001-project"
}

variable "Instance_name" {
  default = "nginx-terraform"
}

variable "Type_Machine" {
  default = "custom-1-4608"
}

variable "RegionAndZone" {
  default = "us-central1-c"
}

variable "Type_Disk" {
  default = "pd-ssd"
}

variable "Size_Disk" {
  default = "30"
}

variable "Image_OS" {
  default = "ubuntu-1604-xenial-v20200129"
}

variable "Network" {
  default = "default"
}

variable "Server_Type" {
  default = "nginxserver"
}

variable "OS_Family" {
  default = "debian"
}

variable "WayOfInstallation" {
  default = "terraform"
}
