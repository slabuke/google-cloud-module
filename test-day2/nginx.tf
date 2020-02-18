variable "project" {
default = "my-epamlab0001-project"
}

variable "region_zone" {
default  = ["us-central1-a", "us-central1-c"]
}

variable "name" {
default = ["nginx-classwork-terraform1", "nginx-classwork-terraform1"]
}

variable "instance_names" {
default = {
"0" = "nginx-classwork-terraform1"
"1" = "nginx-classwork-terraform2"
}
}
variable "mtype" {
default = "custom-1-1792"
}
variable "tag" {
default = ["http-server", "https-server"]
}

variable "image" {
default = "ubuntu-os-cloud/ubuntu-1604-xenial-v20200129"
}

variable "instance_count" {
  default = "2"
}

variable "size_disk" {
default = ["30","35", "10"]
}

variable "type_disk" {
default = ["pd-ssd", "pd-standard"]
}

variable "label" {
default = ["nginxserver", "debian", "terraform"]
}

variable "type_network"{
default  = "default"
}

variable "sscript" {
default= <<SCRIPT
 sudo apt-get update -y
 sudo apt-get install nginx -y
 sudo systemctl enable nginx
 sudo systemctl start nginx
 SCRIPT
}


output "URL" {
    value = "${google_compute_instance.default.*.network_interface.0.access_config.0.nat_ip}"
}

