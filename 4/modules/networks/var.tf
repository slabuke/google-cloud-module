#-----------------------networking:------------------

#----------------subnet 1:----------------
variable "Subnet_1" {
  type        = "string"
  default     = "public"
  description = "Subnet 1"
}

#----------------subnet 2:----------------
variable "Subnet_2" {
  type        = "string"
  default     = "private"
  description = "Subnet 2"
}

#----------------my net:----------------
variable "network_name" {
  type        = "string"
  default     = "dmitriy-mv"
  description = "Network"
}

#----------------net region:----------------
variable "network-region" {
  default     = "us-central1"
  description = "Region"
}

#----------------net 1 range:----------------
variable "Subnet1_cidr" {
  default     = "10.12.1.0/24"
  description = "IP range 1"
}

#----------------net 2 range:----------------
variable "Subnet2_cidr" {
  default     = "10.12.2.0/24"
  description = "IP range 2"
}
