# Terraform global variables

variable "Count" { default = 2 }
variable "Name" { default = "nginx-classwork-terraform" }

variable "Region" { default = "us-central1" }
variable "Zone" { default = "us-central1-a" }
variable "Project" { default = "vm-creating-codelab" }
variable "Tags" { default = [ "http-server", "https-server" ] }
variable "Type" { default = "g1-small"  }
variable "DiskImage" { default = "ubuntu-minimal-1604-xenial-v20200129" }
variable "DiskType" { default = "pd-ssd" }
variable "DiskSize" { default = 30 }
variable "Provision" { default = "sudo yum install -y nginx\nsudo systemctl restart nginx"  }
variable "LabelST" { default = "nginxserver" }
variable "LabelOF" { default = "debian" }
variable "LabelWay" { default = "terraform" }
variable "Network" { default = "default" }
#variable "nname" { default = "" }
#variable "vval" { default = "" }

#var.nname = "${var.Name}-${count.index + 1}"
#var.vval = "google_compute_instance.${var.nname}.network_in    terface.0.access_config.0.nat_ip"
