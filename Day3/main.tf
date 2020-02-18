provider "google" {
  credentials = "${file("/home/student/ter/.andrei-leanovich-84-02ef3fc6ad58.json")}"

  project = "andrei-leanovich-84"

  region = "${var.region}"
  zone   = "${var.zone}"
}
