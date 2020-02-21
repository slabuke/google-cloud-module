provider "google" {
  credentials = "${file("terraform-admin.json")}"
  project     = "${var.project_name}"
  region      = "${var.region}"
}

module "network" {
  source      = "./modules/network"
}
module "bastion" {
  source      = "./modules/bastion"
  vpc         = "${module.network.vpc}"
  pub-sub     = "${module.network.pub-sub}" 
}
module "ig" {
  source      = "./modules/ig"
  vpc         = "${module.network.vpc}"
  pub-sub     = "${module.network.pub-sub}" 
}
module "int-ig" {
  source      = "./modules/int-ig"
  vpc         = "${module.network.vpc}"
  priv-sub    = "${module.network.priv-sub}" 
}

module "autoscaler" {
  source      = "./modules/autoscaler"
  group-manager  = "${module.ig.group-manager}"
}

module "gce-lb-http" {
  version      = "1.0.10"
  source       = "GoogleCloudPlatform/lb-http/google"
  name         = "group-http-lb"
  target_tags  = ["web"]
  backends     = {
    "0" = [
      { group  = "${module.ig.group-name}" }
    ],
  }
  backend_params = ["/,http,80,10"]
}

module "int-lb" {
  source      = "./modules/int-lb"
  vpc         = "${module.network.vpc}"
  priv-sub    = "${module.network.priv-sub}" 
  group-name  = "${module.int-ig.group-name}"
}

resource "google_storage_bucket" "static-content-store" {
  name     = "static-content-store-bucket"
  location = "US"

  website {
    main_page_suffix = "index.html"
    not_found_page   = "404.html"
  }
}