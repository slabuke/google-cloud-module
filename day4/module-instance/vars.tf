variable "student_name" {
  default = "mbazhok"
  }

variable "image" {
  default = "centos-cloud/centos-7"
}

variable "disk-size" {
  default = "30"
}

variable "disk-type" {
  default = "pd-ssd"
}

variable "labels" {
default = {
"0" = "bastion"
"1" = "centos"
"2" = "terraform"
 }
}

variable "doscript" {
default = <<SCRIPT
sudo yum install -y nginx
sudo systemctl enable nginx
sudo systemctl start nginx
SCRIPT
}

output "studname" {
  value = "${var.student_name}"
}

variable "vpc" {}

variable "subnet" {}
