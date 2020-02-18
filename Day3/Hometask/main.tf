provider "google" {
  credentials = "${file("terraform-admin.json")}"
  project     = "gothic-isotope-268209"
  region      = "us-central1"
}


