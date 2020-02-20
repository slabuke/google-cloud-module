provider "google" {
  credentials = "${file("terraform-admin.json")}"
  project     = "${var.project}"
  region      = "${var.region[0]}"
}

module "networking" {
  source = "./network"
}

module "bastion" {
  source = "./modules/bastion"
  network = "${module.networking.network}"
  publicsub = "${module.networking.publicsub}"
}

module "instances" {
  source = "./modules/instances"
  network = "${module.networking.network}"
  publicsub = "${module.networking.publicsub}"
  privatsub = "${module.networking.privatsub}"
}

module "tcplb" {
  source = "./modules/tcplb"
  tempdb ="${module.instances.dbt}"
  network = "${module.networking.network}"
  privatsub = "${module.networking.privatsub}"
}

module "httplb" {
  source = "./modules/httplb"
  tempnginx ="${module.instances.nginxt}"

}




