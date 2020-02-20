provider "google" { 

  credentials = "${file("my-first98764321-project-fc51d2820eca.json")}"

  project     = "my-first98764321-project" 

  region      = "us-central1" 
  
  zone        = "us-central1-c" 

}  


module "networks" {
  source = "./modules/networks"
}

module "instances" {
  source = "./modules/instances"
 google_compute_firewall_ssh_name = "${module.networks.google_compute_firewall_ssh_name}"
  public_subnetwork = "${module.networks.public_subnetwork}"
  private_subnetwork = "${module.networks.private_subnetwork}"
}

module "load_balancer" {
  source = "./modules/load_balancer"
  private_subnetwork = "${module.networks.private_subnetwork}"
  public_managed_group = "${module.instances.public_managed_group}"
  private_managed_group = "${module.instances.private_managed_group}"
}
