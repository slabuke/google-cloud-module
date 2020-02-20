provider "google" {
  credentials = "${file(".luckylockypro-f85aaad6e122.json")}"
  project     = "luckylockypro"
  region      = "us-central1"
}

module "networks" {
  source = "./modules/networks"
}

module "instances" {
  source                           = "./modules/instances"
  network_name                     = "${module.networks.network_name}"
  Subnet_1                         = "${module.networks.Subnet_1}"
  Subnet_2                         = "${module.networks.Subnet_2}"
  google_compute_firewall_ssh_name = "${module.networks.google_compute_firewall_ssh_name}"
}

module "loadbalancer" {
  source                = "./modules/loadbalancer"
  public_managed_group  = "${module.instances.public_managed_group}"
  private_managed_group = "${module.instances.private_managed_group}"
  network_name          = "${module.networks.network_name}"
  Subnet_2              = "${module.networks.Subnet_2}"
}
