variable "Project" { default = "devopslab2020-gcp-module" }
variable "Region" { default = "us-central1" }
variable "Tags" { default = [ "nginx" ] }
variable "STags" { default = [ "bastion", "nginx" ] }
variable "DTags" { default = [ "db" ] }
variable "student_name" { default = "skazak" }
variable "Zones" { default = ["us-central1-a", "us-central1-b", "us-central1-c"] }