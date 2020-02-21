variable "project_name" {
	description = "project_name"
	type        = "string"
	default     = "my-cloudstorage-codelab"
}

variable "region" {
	default     = "us-central1"
}

variable "name" {
	default     = "askvarchevski"
}

variable "vpc" { }
variable "pub-sub" { }