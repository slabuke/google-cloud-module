resource "google_compute_instance_template" "dbinstance" {
  name        = "db-srv"
  tags        = ["http-server"]
  region      = "us-central1"

  labels = {
    environment = "dev"
  }

  machine_type         = "n1-standard-1"
  can_ip_forward       = true

  // Create a new boot disk from an image
  disk {
    source_image = "ubuntu-os-cloud/ubuntu-1804-lts"
    auto_delete  = true
    boot         = true
  }


  network_interface {
    subnetwork = "${var.subnet-private}"
   // access_config {}
  }

metadata_startup_script = "${var.db_nginx_setup}"

}

resource "google_compute_region_instance_group_manager" "web_db_group" {
  name                       = "db-region"
  target_size                = "3"
  base_instance_name         = "db-web"
  region                     = "us-central1"
//  distribution_policy_zones  = ["us-central1-a", "us-central1-b", "us-central1-c"]
  version {
    instance_template  = "${google_compute_instance_template.dbinstance.self_link}"
  }  
}

output "db-group" {
  value = "${google_compute_region_instance_group_manager.web_db_group.instance_group}"
}
