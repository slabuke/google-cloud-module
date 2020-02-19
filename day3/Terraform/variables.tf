# Terraform global variables

variable "Name" { default = "nginx-skazak" }

variable "Region" { default = "us-central1" }
variable "Zone" { default = "us-central1-a" }
variable "Project" { default = "devopslab2020-gcp-module" }
variable "Tags" { default = [ "http-server", "https-server" ] }
variable "Type" { default = "g1-small"  }
variable "DiskImage" { default = "ubuntu-minimal-1604-xenial-v20200129" }
variable "DiskType" { default = "pd-ssd" }
variable "DiskSize" { default = 30 }
variable "Provision" { default = "sudo apt update\n sudo apt install -y nginx --fix-missing\nsudo systemctl restart nginx\nsudo bash -c \"echo 'Hello from skazak' > /var/www/html/index.nginx-debian.html\""  }
variable "LabelST" { default = "nginxserver" }
variable "LabelOF" { default = "debian" }
variable "LabelWay" { default = "terraform" }
variable "student_name" { default = "skazak" }
variable "FirewallName" { default = "task5-firewall" }