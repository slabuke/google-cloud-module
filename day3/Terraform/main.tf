# Revise variables.tf for vars

# VPC Network and Subnetworks

module "networking" {
  source = "./modules/networking"
  student_name = "${var.student_name}"
}

# Template for Nginx Web instance

## Each instance has running nginx on port 80
## Default number of instances is 1
## Autoscaling enabled: 1 to 3 instances

module "template-web" {
  source = "./modules/templates/web"
  project = "${var.Project}"
  name = "nginx-web"
  vpc-name = "${module.networking.vpc-name}"
  sub-vpc-public-name = "${module.networking.sub-vpc-public-name}"
}

# Template for DB instances

## Each instance has running nginx on port 80 with custom index page for checks
## Default number of instances is 3
## Autoscaling enabled: 3 to 5 instances

module "template-db" {
  source = "./modules/templates/db"
  project = "${var.Project}"
  name = "db"
  vpc-name = "${module.networking.vpc-name}"
  sub-vpc-private-name = "${module.networking.sub-vpc-private-name}"
}

# Static Global IPs

module "addresses" {
  source = "./modules/addresses"
}

# Bastion Host instance

module "instances" {
  source = "./modules/instances"
  project = "${var.Project}"
  name = "bastion-skazak"
  bastion-ip-address = "${module.addresses.bastion-ip-address}"
  vpc-name = "${module.networking.vpc-name}"
  sub-vpc-public-name = "${module.networking.sub-vpc-public-name}"
}

# VPC Firewall rules

module "firewall" {
  source = "./modules/firewall"
  name = "task5-firewall"
  vpc-self_link = "${module.networking.vpc-self_link}"
}

# Nginx Web Region Instance Group

module "group-public" {
  source = "./modules/groups/public"
  project = "${var.Project}"
  name = "nginx-group"
  region = "${var.Region}"
  zones = "${var.Zones}"
  template = "${module.template-web.template-self_link}"
  size = 1
}

# DB Region Instance Group

module "group-private" {
  source = "./modules/groups/private"
  project = "${var.Project}"
  name = "db-group"
  region = "${var.Region}"
  zones = "${var.Zones}"
  template = "${module.template-db.template-self_link}"
  vpc-name = "${module.networking.vpc-name}"
  size = 3
}

# Global HTTP Loadbalancer

module "lb-http" {
  source = "./modules/lb/external"
  ign = "${module.group-public.instance-group_name}"
  name = "http-lb"
  target_tags = ["web"]
}

# Internal Loadbalancer

module "lb-internal" {
  source = "./modules/lb/internal"
  name = "db-lb"
  backend_name = "db-backend"
  hcheck_name = "check-backend"
  region = "${var.Region}"
  source_tags = "${var.STags}"
  destination_tags = "${var.DTags}"
  ign = "${module.group-private.instance-group_name}"
  vpc-name = "${module.networking.vpc-name}"
  sub-vpc-private-name = "${module.networking.sub-vpc-private-name}"
}

# Autoscaler for Nginx Web Instance Group

module "autoscaler-web" {
  source = "./modules/autoscalers/web"
  name = "igm-autoscaler-web"
  region = "${var.Region}"
  igm-web = "${module.group-public.igm-web-self_link}"
  min = 1
  max = 3
}

# Autoscaler for DB Instance Group

module "autoscaler-db" {
  source = "./modules/autoscalers/db"
  name = "igm-autoscaler-db"
  region = "${var.Region}"
  igm-db = "${module.group-private.igm-db-self_link}"
  min = 3
  max = 5
}

# Bucket for tfstate

# module "storage" {
#   source = "./modules/storage"
#   name = "skazak-tf-state-prod"
#   location = "US"
# }

# Credentials, Project, default region and gcp version to use

provider "google" {
  credentials = "${file("../../devopslab2020-gcp-module.json")}"
  project = "${var.Project}"
  region = "${var.Region}"
  version = "2.20"
}

terraform {
  project = "${var.Project}"
  backend "gcs" {
    bucket  = "skazak-tf-state-prod"
    prefix  = "terraform/state"
  }
}
