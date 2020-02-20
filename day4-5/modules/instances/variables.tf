variable "bastion_name" {
  default = "bastion"
}

variable "count" {
  default = 1
}

variable "size" {
  default = 10
}

variable "type" {
   default = "pd-ssd"
 }

variable "image" {
  default = "centos-7-v20200205"
}

variable "machine_type" {
  default = "g1-small"
}
variable "region" {
  default = "us-central1"
}

variable "zone" {
  default  = "us-central1-a"
}

variable "bastion_tags" {
  default = ["ssh", "ssh-server"]
}

variable "db_tags"{
  default = ["open", "ssh-internal"]
}

variable "nginx_tags"{
  default = ["http", "ssh-internal"]
}

variable "source_image" {
  default = "centos-cloud/centos-7"
}

variable "pr_target_size" {
  default = 3
}
variable "pb_target_size" {
  default = 1
}
variable "script" {
  default = "sudo yum update -y \n sudo yum install nginx -y \n sudo systemctl restart nginx \n sudo echo 'Hello from Anastasiya Brytsikava!' > /tmp/index1.html \n cp /tmp/index1.html /usr/share/nginx/html/index.html" 
}

variable "student_name" {
  default = "brytsikava"
}
variable "public_subnetwork" {}

variable "private_subnetwork" {}

variable "google_compute_firewall_ssh_name" {}
