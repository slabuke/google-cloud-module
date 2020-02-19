variable "project" {
  default = "my-epamlab0001-project"
}

variable "instance_count" {
  default = "2"
}

variable "region" {
  default  = ["us-central1", "us-west1", "us-west2"]
}

variable "region_zone" {
  default  = ["us-central1-a", "us-central1-b", "us-central1-c"]
}

variable "name" {
  type="list"
  default = ["nginx-terraform1", "nginx-terraform2"]
}

variable "mtype" {
  default = ["custom-1-1792", "g1-small", "custom-1-4608"]
}
variable "tag" {
  default = ["http-server", "https-server", "ssh"]
}

variable "image" {
  default = [
  "ubuntu-os-cloud/ubuntu-1604-lts",
  "centos-cloud/centos-7"
  ]
}

variable "size_disk" {
  default = ["10", "25", "30", "35"]
}

variable "type_disk" {
  default = ["pd-ssd", "pd-standard"]
}

variable "label" {
  default = ["nginxserver", "debian", "redhat", "terraform"]
}

variable "student_name" {
  default = "maxim"
}

variable "public-ip_cidr_range" {
  default     = "10.7.1.0/24"
  description = "public IP range related to ID"
}

variable "private-ip_cidr_range" {
  default     = "10.7.2.0/24"
  description = "private IP range related to ID"
}


variable "sscript" {
default= <<SCRIPT
 sudo yum update -y
 sudo yum install nginx -y
 sudo echo "<h1>Hello from Maxim Filipovich!</h1>" > /usr/share/nginx/html/index.html
 sudo systemctl enable nginx
 sudo systemctl start nginx
 SCRIPT
}


