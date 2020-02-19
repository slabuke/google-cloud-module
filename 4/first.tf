provider "google" {
  credentials = "${file(".vocal-door-268207-231b2e12386e.json")}"
  project     = "vocal-door-268207"
  region      = "us-central1"
}

module "networks" {
  source = "./modules/networks"
}

module "instances" {
  source = "./modules/instances"
}
