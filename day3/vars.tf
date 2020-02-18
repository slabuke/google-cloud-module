variable "student_name" {
  default = "mbazhok"
  }

variable "image" {
  default = "centos-cloud/centos-7"
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
"1" = "centos"
"2" = "terraform"
 }
}

variable "doscript" {
 default = <<SCRIPT
sudo yum install -y nginx 
sudo systemctl enable nginx
sudo echo "<h1>Hello from mbazhok!</h1>" > /usr/share/nginx/html/index.html
sudo systemctl start nginx
SCRIPT
}




