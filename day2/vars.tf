variable "image" {
  default = "centos-cloud/centos-7"
}

variable "disk-size" {
  default = "35"
}

variable "disk-type" {
  default = "pd-ssd"
}

variable "labels" {
default = {
"0" = "nginx_server"
"1" = "redhat"
"2" = "terraform"
 }
}

variable "doscript" {
 default = <<EOF
sudo yum install nginx -y
sudo systemctl enable nginx
sudo systemctl start nginx
EOF
}

variable "attdisk"{
	default = {
"0" = "pd-standard"
"1" = "us-central1-c"
"2" = "10"
 }
}

output "URL" {
    value = "http://${google_compute_instance.default.network_interface.0.access_config.0.nat_ip}"
}