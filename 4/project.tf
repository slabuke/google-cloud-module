provider "google" {
  credentials = "${file(".luckylocky-8042bd02aa86.json")}"
  project     = "LuckyLocky"
  zone        = "us-central1-a"
}
