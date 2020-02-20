provider "google" {
  credentials = "${file("/home/student/ter/.andrei-leanovich-84-02ef3fc6ad58.json")}"
  project     = "andrei-leanovich-84"
  region      = "us-central1"
}

module "lb" {
  source                     = "./modules/loadbalancing"
  public_managed_group       = "${module.instances.public_managed_group}"
  private_managed_group      = "${module.instances.private_managed_group}"
  vpc_name                   = "${module.networks.vpc_name}"
  Subnet-2-name              = "${module.networks.Subnet-2-name}"
  public_managed_group_link  = "${module.instances.public_managed_group_link}"
  private_managed_group_link = "${module.instances.private_managed_group_link}"
}

module "instances" {
  source                           = "./modules/instances"
  vpc_name                         = "${module.networks.vpc_name}"
  Subnet-1-name                    = "${module.networks.Subnet-1-name}"
  Subnet-2-name                    = "${module.networks.Subnet-2-name}"
  google_compute_firewall_ssh_name = "${module.networks.google_compute_firewall_ssh_name}"
}

module "networks" {
  source = "./modules/networks"
}
