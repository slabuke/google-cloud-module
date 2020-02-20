variable "project" {
  type = "string"
  description = "Set name of project"
  default = "glassy-hue-268209"
}

variable "network_name" {

}

variable "subnet-private" {

}

variable "subnet-public" {

}

variable "nginx_setup"{
  default = <<SCRIPT
sudo apt-get -y update
sudo apt-get -y install nginx
sudo echo "<h1>Hello from sweet DevOps</h1>" > /var/www/html/index.nginx-debian.html
sudo systemctl start nginx
sudo systemctl enable nginx
SCRIPT
}
