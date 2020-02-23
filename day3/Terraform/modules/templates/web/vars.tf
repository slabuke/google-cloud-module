variable "Tags" { default = [ "nginx" ] }
variable "Type" { default = "n1-standard-1"  }
variable "DiskImage" { default = "centos-cloud/centos-7" }
variable "DiskType" { default = "pd-ssd" }
variable "DiskSize" { default = 30 }
variable "Provision" { default = "sudo yum update -y \nsudo yum install epel-release -y \nsudo yum install nginx -y \nsudo systemctl start nginx \nsudo systemctl enable nginx"  }
variable "vpc-name" {}
variable "sub-vpc-public-name" {}
variable "project" {}
variable "name" {}