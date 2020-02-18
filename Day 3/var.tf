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
  default = "ubuntu"
}

variable "WayOfInstallation" {
  default = "terraform"
}

variable "sh" {
  default = "sudo apt update\n sudo apt install -y nginx \nsudo systemctl start nginx\nsudo bash -c \"echo 'Hello from Kirill_Baravoy!' > /var/www/html/index.html\""
}
