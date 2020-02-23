resource "google_compute_instance" "bastion" {
  name         = "bastion"
  project      = "${var.project}"
  machine_type = "n1-standard-1"
  zone         = "us-central1-c"

  boot_disk {
    initialize_params {
      image = "ubuntu-1604-xenial-v20200129"
    }
  }

  network_interface {
    subnetwork = "${var.subnet-public}"

    access_config {
      # Ephemeral IP - leaving this block empty will generate a new external IP and assign it to the machine
    }
  }

  tags = ["bastion"]
}

resource "google_compute_instance_template" "nginx_web" {
  name        = "web-nginx"
  tags        = ["http-server"]

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
    subnetwork = "${var.subnet-public}"
   // access_config {}
  }

metadata_startup_script = "${var.nginx_setup}"

}


data "google_compute_region_instance_group" "web_private_group" {
  name        = "instance-group-public"
  //description = "insance group for nginx-terraform"
}


resource "google_compute_region_instance_group_manager" "web_private_group" {
  name               = "nginx-region"
  target_size        = "1"
  base_instance_name = "nginx-web"
  region             = "us-central1"
  version {
    instance_template  = "${google_compute_instance_template.nginx_web.self_link}"
  }  
}


# determine whether instances are responsive and able to do work
resource "google_compute_health_check" "healthcheck" {
  name = "nginx-healthcheck"
  timeout_sec = 1
  check_interval_sec = 1
  http_health_check {
    port = 80
  }
}


output "web_private_group" {
  value = "${google_compute_region_instance_group_manager.web_private_group.instance_group}"
}

output "health_check" {
  value = "${google_compute_health_check.healthcheck.self_link}"
}
