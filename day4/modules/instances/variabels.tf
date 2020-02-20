variable "project" {
  default = "my-epamlab0001-project"
}

variable "region" {
  default  = ["us-central1"]
}

variable "region_zone" {
  default  = ["us-central1-a", "us-central1-b", "us-central1-c"]
}

variable "mtype" {
  default = ["custom-1-1792", "g1-small", "custom-1-4608"]
}
variable "tag" {
  default = ["http-server", "https-server", "ssh", "telnet"]
}

variable "image" {
  default = [
  "ubuntu-os-cloud/ubuntu-1604-lts",
  "centos-cloud/centos-7"
  ]
}

variable "size_disk" {
  default = ["10", "25", "30", "35"]
}

variable "type_disk" {
  default = ["pd-ssd", "pd-standard"]
}

variable "label" {
  default = ["nginxserver", "debian", "redhat", "terraform", "bastion"]
}