# Networks variables
variable "subnet-1-name" {
  type        = "string"
  default     = "public"
  description = "subnet-1 for kbaravoy-vpc"
}

variable "subnet-2-name" {
  type        = "string"
  default     = "private"
  description = "subnet-2 for kbaravoy-vpc"
}

variable "network_name" {
  type        = "string"
  default     = "kbaravoy-vpc"
  description = "Network link"
}

variable "network-region" {
  default     = "us-central1"
  description = "Current region"
}
variable "subnet-1-range" {
  default     = "10.10.1.0/24"
  description = "IP range for subnet-1"
}
variable "subnet-2-range" {
  default     = "10.10.2.0/24"
  description = "IP range for subnet-2"
}
