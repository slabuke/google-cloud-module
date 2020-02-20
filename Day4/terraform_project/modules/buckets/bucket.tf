resource "google_storage_bucket" "bucket-terraform-321" {
  name     = "${var.bucket_name}"
  location = "${var.region}"
}
