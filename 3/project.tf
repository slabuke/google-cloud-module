provider "google" {
  credentials = "${file(".instant-river-268209-57e284821158.json")}"
  project     = "instant-river-268209"
  zone        = "us-central1-a"
}
