#networking:
variable "Subnet-1-name" {
  type        = "string"
  default     = "public"
  description = "Subnet 1 to create on GCP"
}

variable "Subnet-2-name" {
  type        = "string"
  default     = "private"
  description = "Subnet 2 to create on GCP"
}

variable "network_name" {
  type        = "string"
  default     = "dmitriy-vpc"
  description = "Direct link to the network"
}

variable "network-region" {
  default     = "us-central1"
  description = "Zone associated with the network. This defaults to the region configured in the provider."
}

variable "Subnet-1-ip_cidr_range" {
  default     = "10.12.1.0/24"
  description = "IP range to book"
}

variable "Subnet-2-ip_cidr_range" {
  default     = "10.12.2.0/24"
  description = "IP range to book"
}
