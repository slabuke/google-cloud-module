module "instance" {
  source = "./module-instance"

  vpc = "${module.network.vpc}"
  subnet = "${module.network.subnet}"
}

module "network" {
  source = "./module-network"

  studname = "${module.instance.studname}"
}

module "instancepriv" {
  source = "./module-private_inst"

  vpc = "${module.network.vpc}"
  subnetpriv = "${module.network.subnetpriv}"
}
  
resource "google_storage_bucket" "gcplabtask4_bucket" {
  name     = "letstryanewnameforthisbucket"
  location = "US"
}
