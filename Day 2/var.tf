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
  default = "35"
}

variable "Image_OS" {
  default = "centos-7"
}

variable "Server_Type" {
  default = "nginxserver"
}

variable "OS_Family" {
  default = "redhat"
}

variable "WayOfInstallation" {
  default = "terraform"
}
