# Revise variables.tf for vars

provider "google" {
	credentials = "${file("../../devopslab2020-gcp-module.json")}"
	project = "${var.Project}"
	region = "${var.Region}"
}
