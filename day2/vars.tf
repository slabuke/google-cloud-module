variable "name" {
  default = "nginx-terraform"
}
variable "machine_type" {
  default = "custom-1-4608"
}

variable "zone" {
  default = "us-central1-c"
}
variable "image" {
  default = "centos-7-v20200205"
}
variable "size" {
  default = 35
}
variable "type" {
  default = "pd-ssd"
}
variable "network" {
  default = "default"
}
variable "script" {
  default = "sudo yum update -y \n sudo yum install nginx -y \n sudo systemctl restart nginx"
}
variable "servertype" {
  default = "nginxserver"
}
variable "osfamily" {
  default = "redhat"
}
variable "wayofinstallation" {
  default = "terraform" 
}
variable "deletion_protection" {
  default = true
}
variable "tags" {
  default = ["http-server","https-server"]
}

output "link" {
  value = "http://${google_compute_instance.vm_instance.network_interface.0.access_config.0.nat_ip}"
}


