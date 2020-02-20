provider "google" {
  credentials = "${file(".luckylockypro-f85aaad6e122.json")}"
  project     = "luckylockypro"
  region      = "us-central1"
}

module "networks" {
  source = "./modules/networks"
}

module "instances" {
  source = "./modules/instances"
}
