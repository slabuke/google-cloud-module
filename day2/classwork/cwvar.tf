//var

variable "instance_names" {
default = {
"0" = "nginx-classwork-terraform1"
"1" = "nginx-classwork-terraform2"
}
}

variable "instance_count" {
  default = "2"
}

variable "image" {
  default = "ubuntu-os-cloud/ubuntu-minimal-1604-lts"
}

variable "disk-size" {
  default = "30"
}

variable "disk-type" {
  default = "pd-ssd"
}

variable "labels" {
default = {
"0" = "nginx_server"
"1" = "debian"
"2" = "terraform"
 }
}

variable "doscript" {
 default = <<EOF
sudo apt-get update
sudo apt-get install nginx 
sudo systemctl enable nginx
sudo systemctl start nginx
EOF
}

variable "description"{
	default = {
"0" = "first cw instance"
"1" = "second cw instance"
 }
}


// output "URL" {
//    value = "http://${google_compute_instance.default.network_interface.0.//access_config.0.nat_ip}"
//}

output "url" {
  value = "${google_compute_instance.default.*.network_interface.0.access_config.0.nat_ip }"
}

resource "null_resource" "app" {
count = "${length(var.instance_names)}"
provisioner "local-exec" {
command = "echo name ${lookup(var.instance_names, count.index)} "
command = "echo description ${lookup(var.description, count.index)} "
}
}