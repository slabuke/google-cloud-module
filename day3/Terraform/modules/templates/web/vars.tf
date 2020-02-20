variable "Project" { default = "devopslab2020-gcp-module" }
variable "Region" { default = "us-central1" }
variable "Zone" { default = "us-central1-b" }
variable "Name" { default = "skazak" }
variable "Tags" { default = [ "nginx" ] }
variable "Type" { default = "n1-standard-1"  }
variable "DiskImage" { default = "centos-cloud/centos-7" }
variable "DiskType" { default = "pd-ssd" }
variable "DiskSize" { default = 30 }
variable "Provision" { default = "sudo yum update -y \nsudo yum install epel-release -y \nsudo yum install nginx -y \nsudo systemctl start nginx \nsudo systemctl enable nginx"  }
variable "LabelST" { default = "nginxserver" }
variable "LabelWay" { default = "terraform" }
variable "student_name" { default = "skazak" }
variable "vpc-name" {}
variable "sub-vpc-public-name" {}