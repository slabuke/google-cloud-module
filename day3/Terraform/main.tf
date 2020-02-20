# Revise variables.tf for vars

# VPC Network and Subnetworks

module "networking" {
  source = "./modules/networking"
}

# Template for Nginx Web instance

## Each instance has running nginx on port 80
## Default number of instances is 1
## Autoscaling enabled: 1 to 3 instances

module "template-web" {
  source = "./modules/templates/web"
  vpc-name = "${module.networking.vpc-name}"
  sub-vpc-public-name = "${module.networking.sub-vpc-public-name}"
}

# Template for DB instances

## Each instance has running nginx on port 80 with custom index page for checks
## Default number of instances is 3
## Autoscaling enabled: 3 to 5 instances

module "template-db" {
  source = "./modules/templates/db"
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
  bastion-ip-address = "${module.addresses.bastion-ip-address}"
  vpc-name = "${module.networking.vpc-name}"
  sub-vpc-public-name = "${module.networking.sub-vpc-public-name}"
}

# VPC Firewall rules

module "firewall" {
  source = "./modules/firewall"
  vpc-self_link = "${module.networking.vpc-self_link}"
}

# Nginx Web Region Instance Group

module "group-public" {
  source = "./modules/groups/public"
  template-self_link = "${module.template-web.template-self_link}"
}

# DB Region Instance Group

module "group-private" {
  source = "./modules/groups/private"
  template-self_link = "${module.template-db.template-self_link}"
  vpc-name = "${module.networking.vpc-name}"
}

# Global HTTP Loadbalancer

module "lb-http" {
  source = "./modules/lb/external"
  instance-group_name = "${module.group-public.instance-group_name}"
}

# Internal Loadbalancer

module "lb-internal" {
  source = "./modules/lb/internal"
  instance-group_name = "${module.group-private.instance-group_name}"
  vpc-name = "${module.networking.vpc-name}"
  sub-vpc-private-name = "${module.networking.sub-vpc-private-name}"
}

# Autoscaler for Nginx Web Instance Group

module "autoscaler-web" {
  source = "./modules/autoscalers/web"
  igm-web-self_link = "${module.group-public.igm-web-self_link}"
}

# Autoscaler for DB Instance Group

module "autoscaler-db" {
  source = "./modules/autoscalers/db"
  igm-db-self_link = "${module.group-private.igm-db-self_link}"
}

# Credentials, Project, default region and gcp version to use

provider "google" {
  credentials = "${file("../../devopslab2020-gcp-module.json")}"
  project = "${var.Project}"
  region = "${var.Region}"
  version = "2.20"
}
