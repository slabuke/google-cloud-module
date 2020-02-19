data "google_compute_region_instance_group" "group" {
  name = "day4-ig"
  region = "us-central1"
}

resource "google_compute_region_instance_group_manager" "foo" {
  name               = "day4-igm"
  target_size = "1"
  base_instance_name = "site"
  region = "us-central1"
  instance_template  = "${google_compute_instance_template.site.self_link}"

}

