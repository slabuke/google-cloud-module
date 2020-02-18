provider "google" {
  credentials = "${file("terraform-admin.json")}"
  project     = "gcplabunit1402"
  region      = "us-central1"
}
