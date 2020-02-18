variable "name" {
  default = {
"0" = "nginx-classwork-terraform1"
"1" = "nginx-classwork-terraform2"
}
}
variable "machine_type" {
  default = "g1-small"
}

variable "zone" {
  default = "us-central1-a"
}
variable "image" {
  default = "ubuntu-1604-xenial-v20200129"
}
variable "size" {
  default = 30
}
variable "type" {
  default = "pd-ssd"
}
variable "network" {
  default = "default"
}
variable "script" {
  default = "sudo apt-get update \n sudo apt-get install nginx -Y \n sudo systemctl restart nginx "
}
variable "servertype" {
  default = "nginxserver"
}
variable "osfamily" {
  default = "debian"
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
variable "description" {
  default = {
"0" = "This is description for first instance"
"1" = "This is description for second instance"
}
}

variable "timeouts" {
 default = "40m"
}



