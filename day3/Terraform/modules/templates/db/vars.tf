variable "Tags" { default = [ "db" ] }
variable "Type" { default = "n1-standard-1"  }
variable "DiskImage" { default = "centos-cloud/centos-7" }
variable "DiskType" { default = "pd-ssd" }
variable "DiskSize" { default = 30 }
variable "Provision" { default = "sudo yum update -y \nsudo yum install epel-release -y \nsudo yum install nginx -y \nsudo bash -c 'echo \"Hello from Siarhei Kazak at $(hostname -I)\" > /usr/share/nginx/html/index.html'\nsudo systemctl restart nginx \nsudo systemctl enable nginx" }
variable "vpc-name" {}
variable "sub-vpc-private-name" {}
variable "project" {}
variable "name" {}