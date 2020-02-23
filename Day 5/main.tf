provider "google" {
  credentials = "${file("dev-001-project-955a035bd555.json")}"
  project     = "dev-001-project"
  region      = "us-central1"
}

# Mount networks module (create firewall rules; VPC networks and subnetworks)
module "networks" {
  source = "./modules/networks"
}

# Mount instances module (create mig1,2; bastion-host)
module "instances" {
  source                           = "./modules/instances"
  network_name                     = "${module.networks.network_name}"
  subnet-1-name                    = "${module.networks.subnet-1-name}"
  subnet-2-name                    = "${module.networks.subnet-2-name}"
  google_compute_firewall_ssh_name = "${module.networks.google_compute_firewall_ssh_name}"
}

# Mount networks module (create Global load-balancer and Internal load-balancer)
module "lb" {
  source                     = "./modules/lb"
  public_managed_group       = "${module.instances.public_managed_group}"
  private_managed_group      = "${module.instances.private_managed_group}"
  public_managed_group_link  = "${module.instances.public_managed_group_link}"
  private_managed_group_link = "${module.instances.private_managed_group_link}"
  network_name               = "${module.networks.network_name}"
  subnet-2-name              = "${module.networks.subnet-2-name}"
}
