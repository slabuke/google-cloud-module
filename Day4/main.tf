provider "google" {
credentials = "${file("vnikiforov-day1-01a8a4fa28c7.json")}"
project = "vnikiforov-day1"
region = "us-central1-c"

}
module "network" {
    source    = "./modules/network"
}

module "bastion" {
  source         = "./modules/bastion"
}

module "ext-ig" {
  source            = "./modules/ext-ig"
}

module "int-ig" {
  source            = "./modules/int-ig"
}

module "ext-lb" {
  source            = "./modules/ext-lb"
  instance-group    = "${module.ext-ig.instance-group}"
}

module "int-lb" {
  source            = "./modules/int-lb"
  instance-group-i  = "${module.int-ig.instance-group-i}"
}
