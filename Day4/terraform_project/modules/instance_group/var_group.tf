variable "subnet-private" {

}

variable "db_nginx_setup"{
  default = <<SCRIPT
sudo apt-get -y update
sudo apt-get -y install nginx
sudo echo "I'm \"$HOSTNAME\"" > /var/www/html/index.nginx-debian.html
sudo systemctl start nginx
sudo systemctl enable nginx
SCRIPT
}
