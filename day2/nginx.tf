variable "project" {
default = "my-epamlab0001-project"
}

variable "region_zone" {
default  = "us-central1-c"
}

variable "name" {
default = "nginx-terraform"
}
variable "mtype" {
default = "custom-1-4608"
}
variable "tag" {
default = ["http-server", "https-server"]
}

variable "image" {
default = "centos-cloud/centos-7"
}

variable "size_disk" {
default = ["35", "10"]
}

variable "type_disk" {
default = ["pd-ssd", "pd-standard"]
}

variable "label" {
default = ["nginxserver", "redhat", "terraform"]
}

variable "type_network"{
default  = "default"
}

variable "sscript" {
default= <<SCRIPT
 sudo yum update -y
 sudo yum install nginx -y
 sudo systemctl enable nginx
 sudo systemctl start nginx
 SCRIPT
}


output "public_ip" {
    value = "${google_compute_instance.default.network_interface.0.access_config.0.nat_ip}"
}
