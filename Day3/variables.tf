variable "region" {
  default = "us-central1"
}

variable "zone" {
  default = "us-central1-c"
}

#=============================VPC=========================

variable "vpc_name" {
  default = "andrei-leanovich"
}

#==========================Subnet=========================

variable "subnet-1-name" {
  type        = "string"
  default     = "public"
  description = "Public Subnet"
}

variable "subnet-2-name" {
  type        = "string"
  default     = "private"
  description = "Private Subnet"
}

variable "cidr-block-1" {
  default = "10.1.1.0/24"
}

variable "cidr-block-2" {
  default = "10.1.2.0/24"
}

#=============================Instance================

variable "cpu" {
  default = 1
}

variable "ram" {
  default = 1792
}

variable "disk_size_gb" {
  default = 30
}

variable "name" {
  default = {
    "1" = "1"
  }
}

variable "nginx" {
  default = <<SCRIPT
sudo yum install -y nginx
sudo systemctl enable nginx
sudo echo "<h1>Hello from Andrei Leanovich!</h1>" > /usr/share/nginx/html/index.html
sudo systemctl start nginx
SCRIPT
}

#=============================================

