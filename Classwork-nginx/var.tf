variable "project_name" {
  description = "project_name"
  type        = "string"
  default     = "my-first123-project"
}

variable "instances"{
default = 2
}

variable "name" {
default = "nginx-classwork-terraform"
}
variable "region" {
default = "us-central1"
}

variable "size" {
default = "30"
}

variable "zones" {
default = "us-central1-a"
}

variable "tags" {
type = "list"
default = ["https-server", "http-server"]
}
