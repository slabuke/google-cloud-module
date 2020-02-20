provider "google" {
  credentials = "${file("artsemiyoursh-day1proj-268813-54c51c38f276.json")}"
  project     = "artsemiyoursh-day1proj-268813"
  region      = "us-central1"
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
