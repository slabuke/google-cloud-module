variable "Student_name" {
  default = "kbaravoy"
}

variable "Instance_count" {
  default = "1"
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

variable "Region" {
  default = "us-central1"
}

variable "Zone" {
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
  default = "ubuntu"
}

variable "WayOfInstallation" {
  default = "terraform"
}
