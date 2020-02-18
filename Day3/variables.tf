
variable "project" {
  type = "string"
  description = "Set name of project"
  default = "glassy-hue-268209"
}

variable "region" {
  type = "string"
  description = "Set region"
  default = "us-central1"
}

variable "zone" {
  type = "string"
  description = "Set zone"
  default = "us-central1-a"
}

variable "name" {
  type = "string"
  description = "Set the name of instance"
  default = "vandrushkevich"
}

variable "deletion"{
  default = true
}

variable "type" {
  type = "string"
  description = "1CPU with 1792 Gb RAM"
  default = "custom-1-1792"
}

variable "disk_size" {
  description = "Size of our drive"
  default = "30"
}

variable "disk_type" {
  type = "string"
  description = "Type of disk"
  default = "pd-ssd"
}

variable "disk_image" {
  type = "string"
  description = "Type of disk image"
  default = "ubuntu-1604-xenial-v20200129"
}

variable "tags" {
  type    = "list"
  default = ["http-server", "https-server"]
}

variable "nginx_setup"{
  default = <<EOF
sudo apt-get -y update
sudo apt-get -y install nginx
sudo echo "<h1>Hello from vandrushkevich!</h1>" >  /var/www/html/index.nginx-debian.html
sudo systemctl start nginx
sudo systemctl enable nginx
EOF
}
