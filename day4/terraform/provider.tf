provider "google" {
  credentials = "${file("artsemiyoursh-day1proj-611e57f2fcb9.json")}"
  project     = "artsemiyoursh-day1proj"
  region      = "us-central1"
}
