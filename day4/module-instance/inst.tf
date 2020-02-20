resource "google_compute_instance" "bastion" {  
  name         = "jumphost"
  machine_type = "n1-standard-1"
  zone         = "us-central1-c"

  tags = ["ssh"]

  boot_disk {
    initialize_params {
      image = "${var.image}"
      size = "${var.disk-size}"
      type = "${var.disk-type}"
    }
  }

  network_interface {
    subnetwork = "${var.subnet}"
    access_config {}    
  }

  labels = {
    server_type = "bastion"
    os_family = "centos"
    way_of_installation = "terraform"
  }

metadata_startup_script = "sudo yum install -y telnet"

}







resource "google_compute_instance_template" "site" {
  name        = "site"
  

  tags = ["http-server", "ssh"]

  labels = {
    server_type = "nginx"
    os_family = "centos"
    way_of_installation = "terraform"
  }

  machine_type         = "n1-standard-1"
  can_ip_forward       = true

  
  disk {
    source_image = "centos-cloud/centos-7"
    auto_delete  = true
    boot         = true
  }


  network_interface {
    subnetwork = "${var.subnet}"
    access_config {}
  }

metadata_startup_script = "#!/bin/bash \nyum update -y \nyum install epel-release -y \nyum install nginx -y \nsystemctl start nginx \nsystemctl enable nginx"

}








resource "google_compute_health_check" "autohealing" {
  name                = "autohealing-health-check"
  check_interval_sec  = 5
  timeout_sec         = 5
  healthy_threshold   = 2
  unhealthy_threshold = 10 

  http_health_check {
    request_path = "/healthz"
    port         = "80"
  }
}

resource "google_compute_target_pool" "mypool" {
  name = "nginx-pool"
}


resource "google_compute_region_instance_group_manager" "1stgroup" {
  
  name = "nginx"
  base_instance_name         = "nginx"
  region                     = "us-central1"
  distribution_policy_zones  = ["us-central1-a", "us-central1-b", "us-central1-c"]

  instance_template = "${google_compute_instance_template.site.self_link}"
  

  target_pools = ["${google_compute_target_pool.mypool.self_link}"]
  target_size  = 1


  auto_healing_policies {
    health_check      = "${google_compute_health_check.autohealing.self_link}"
    initial_delay_sec = 600
  }
}










module "gce-lb-http" {
  version           = "1.0.10"
  source            = "GoogleCloudPlatform/lb-http/google"
  name              = "group-http-lb"
  target_tags       = ["web"]
  backends          = {
    "0" = [
      { group = "https://www.googleapis.com/compute/v1/projects/task4-gcplabproject/regions/us-central1/instanceGroups/${google_compute_region_instance_group_manager.1stgroup.name}" }
    ],
  }
  backend_params = ["/,http,80,10"]
  }









