variable "Project" { default = "devopslab2020-gcp-module" }
variable "ZoneBastion" { default = "us-central1-a" }
variable "Name" { default = "skazak" }
variable "TagsBastion" { default = [ "bastion" ] }
variable "Type" { default = "n1-standard-1"  }
variable "DiskImage" { default = "centos-cloud/centos-7" }
variable "DiskType" { default = "pd-ssd" }
variable "DiskSize" { default = 30 }
variable "ProvisionBastion" { default = "sudo yum update\n sudo yum upgrade\nsudo yum install -y telnet" }
variable "LabelST" { default = "nginxserver" }
variable "LabelSTB" { default = "bastion" }
variable "LabelWay" { default = "terraform" }
variable "student_name" { default = "skazak" }
variable "vpc-name" {}
variable "sub-vpc-public-name" {}
variable "bastion-ip-address" {}