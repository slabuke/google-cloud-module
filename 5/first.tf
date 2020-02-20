provider "google" {
  credentials = "${file(".vocal-door-268207-231b2e12386e.json")}"
  project     = "vocal-door-268207"
  region      = "us-central1"
}

module "networks" {
  source = "./modules/networks"
}

module "instances" {
  source                           = "./modules/instances"
  network_name                     = "${module.networks.network_name}"
  Subnet-1-name                    = "${module.networks.Subnet-1-name}"
  Subnet-2-name                    = "${module.networks.Subnet-2-name}"
  google_compute_firewall_ssh_name = "${module.networks.google_compute_firewall_ssh_name}"
}

module "lb" {
  source                = "./modules/lb"
  public_managed_group  = "${module.instances.public_managed_group}"
  private_managed_group = "${module.instances.private_managed_group}"
  network_name          = "${module.networks.network_name}"
  Subnet-2-name         = "${module.networks.Subnet-2-name}"
}
