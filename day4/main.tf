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