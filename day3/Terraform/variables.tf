# Terraform global variables

variable "Project" { default = "devopslab2020-gcp-module" }
variable "Region" { default = "us-central1" }
variable "Provision" { default = "sudo apt update\n sudo apt install -y nginx --fix-missing\nsudo systemctl restart nginx\nsudo bash -c \"echo 'Hello from skazak' > /var/www/html/index.nginx-debian.html\""  }

