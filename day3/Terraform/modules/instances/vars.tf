variable "project" {}
variable "zone" { default = "us-central1-a" }
variable "name" {}
variable "type" { default = "n1-standard-1"  }
variable "dimage" { default = "centos-cloud/centos-7" }
variable "dtype" { default = "pd-ssd" }
variable "dsize" { default = 30 }
variable "tags" { default = [ "bastion" ] }
variable "script" { default = "sudo yum update\n sudo yum upgrade\nsudo yum install -y telnet" }
variable "label-type" { default = "bastion" }
variable "label-way" { default = "terraform" }
variable "vpc-name" {}
variable "sub-vpc-public-name" {}
variable "bastion-ip-address" {}