# Revise variables.tf for vars

module "networking" {
  source = "./modules/networking"
}

module "template-web" {
  source = "./modules/templates/web"
  vpc-name = "${module.networking.vpc-name}"
  sub-vpc-public-name = "${module.networking.sub-vpc-public-name}"
}

module "template-db" {
  source = "./modules/templates/db"
  vpc-name = "${module.networking.vpc-name}"
  sub-vpc-private-name = "${module.networking.sub-vpc-private-name}"
}

module "addresses" {
  source = "./modules/addresses"
}

module "instances" {
  source = "./modules/instances"
  bastion-ip-address = "${module.addresses.bastion-ip-address}"
  vpc-name = "${module.networking.vpc-name}"
  sub-vpc-public-name = "${module.networking.sub-vpc-public-name}"
}

module "firewall" {
  source = "./modules/firewall"
  vpc-self_link = "${module.networking.vpc-self_link}"
}

module "group-public" {
  source = "./modules/groups/public"
  template-self_link = "${module.template-web.template-self_link}"
}

module "group-private" {
  source = "./modules/groups/private"
  template-self_link = "${module.template-db.template-self_link}"
  vpc-name = "${module.networking.vpc-name}"
}

module "lb-http" {
  source = "./modules/lb/external"
  instance-group_name = "${module.group-public.instance-group_name}"
}

module "lb-internal" {
  source = "./modules/lb/internal"
  instance-group_name = "${module.group-private.instance-group_name}"
  vpc-name = "${module.networking.vpc-name}"
  sub-vpc-private-name = "${module.networking.sub-vpc-private-name}"
}

module "autoscaler-web" {
  source = "./modules/autoscalers/web"
  igm-web-self_link = "${module.group-public.igm-web-self_link}"
}

module "autoscaler-db" {
  source = "./modules/autoscalers/db"
  igm-db-self_link = "${module.group-private.igm-db-self_link}"
}

provider "google" {
  credentials = "${file("../../devopslab2020-gcp-module.json")}"
  project = "${var.Project}"
  region = "${var.Region}"
  version = "2.20"
}
