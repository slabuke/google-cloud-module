provider "google" {
  credentials = "${file("~/gcp/.terraform-admin.json")}"
  project     = "${var.project}"
  zone        = "${var.zone}"
}


module "networks" {
    source    = "./modules/networks"
}

module "instance" {
  source         = "./modules/instance"
  network_name   = "${module.networks.vpc-output}"
  subnet-private = "${module.networks.vpc-private}"
  subnet-public  = "${module.networks.vpc-public}"
}

module "lb" {
  source            = "./modules/lb"
  web_private_group = "${module.instance.web_private_group}"
  health_check      = "${module.instance.health_check}"
  network_name      = "${module.networks.vpc-output}"
  subnet-private    = "${module.networks.vpc-private}"
  db_group          = "${module.db_group.db-group}"
}

 module "db_group" {
   source         = "./modules/instance_group"
   subnet-private = "${module.networks.vpc-private}"
 }