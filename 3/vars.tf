variable "student_name" {
  default = "dmitriy"
}

variable "script" {
  default = "sudo yum update -y \n sudo yum install nginx -y \n sudo systemctl restart nginx \n sudo echo 'Hello from Dmitriy Shishkovets!' > /tmp/index1.html \n cp /tmp/index1.html /usr/share/nginx/html/index.html"
}

variable "firewall" {
  default = "firewall"
}

variable "pr_subnet" {
  default = "private-subnetwork"
}

variable "region" {
  default = "us-central1"
}

variable "pb_subnet" {
  default = "public-subnetwork"
}

variable "ip1" {
  default = "10.12.1.0/24"
}

variable "ip2" {
  default = "10.12.2.0/24"
}

variable "name" {
  default = "nginx-terraform"
}

variable "machine_type" {
  default = "custom-1-4608"
}

variable "zone" {
  default = "us-central1-a"
}

variable "image" {
  default = "centos-7-v20200205"
}

variable "size" {
  default = 10
}

variable "type" {
  default = "pd-ssd"
}

variable "network" {
  default = "default"
}

variable "tags" {
  default = ["http-server", "https-server"]
}
