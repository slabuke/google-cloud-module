# Revise variables.tf for vars

module "networking" {
  source = "./modules/networking"
}

module "instances" {
  source = "./modules/instances"
}

# data "template_file" "startup-script" {
#   template = "${file("${format("%s/../scripts/gceme.sh.tpl", path.module)}")}"
#   vars {
#     PROXY_PATH = ""
#   }
# }

provider "google" {
  credentials = "${file("./devopslab2020-gcp-module.json")}"
  project = "${var.Project}"
  region = "${var.Region}"
}
