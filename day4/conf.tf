provider "google" {
  credentials = "${file("task4-gcplabproject-3ab2e1cc986a.json")}"
  project     = "task4-gcplabproject"
  region      = "us-central1"
}
