resource "google_compute_instance_template" "dbnode" {
  name        = "node"
  
  tags = ["ssh", "http-server"]

  labels = {
    server_type = "priv_node"
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
    subnetwork = "${var.subnetpriv}"
    access_config {}
  }

metadata_startup_script = "sudo yum update -y \nsudo yum install epel-release -y \nsudo yum install nginx -y \nsudo bash -c 'echo \"Hello from mbazhok at $(hostname -I)\" > /usr/share/nginx/html/index.html'\nsudo systemctl restart nginx \nsudo systemctl enable nginx"

}







resource "google_compute_health_check" "scndautohealing" {
  name                = "scnddautohealing-health-check"
  check_interval_sec  = 5
  timeout_sec         = 5
  healthy_threshold   = 2
  unhealthy_threshold = 10 

  http_health_check {
    request_path = "/healthz"
    port         = "80"
  }
}



resource "google_compute_forwarding_rule" "db-rule" {
  name   = "db-lb"
  region = "us-central1"
  load_balancing_scheme = "INTERNAL"
  ports                 = ["80"]
  subnetwork            = "${var.subnetpriv}"
  backend_service       = "${google_compute_region_backend_service.db-backend.self_link}"
}



resource "google_compute_region_backend_service" "db-backend" {
  name          = "db-backend"
  region        = "us-central1"
  health_checks = ["${google_compute_health_check.scndautohealing.self_link}"]

    backend {
    group = "${google_compute_region_instance_group_manager.2ndgroup.instance_group}"
  }
}



resource "google_compute_target_pool" "myscndpool" {
  name = "db-pool"
}



resource "google_compute_region_instance_group_manager" "2ndgroup" {
  
  name = "dbnode"
  base_instance_name         = "db"
  region                     = "us-central1"
  distribution_policy_zones  = ["us-central1-a", "us-central1-b", "us-central1-c"]

  instance_template = "${google_compute_instance_template.dbnode.self_link}"
  

  target_pools = ["${google_compute_target_pool.myscndpool.self_link}"]
  target_size  = 3


  auto_healing_policies {
    health_check      = "${google_compute_health_check.scndautohealing.self_link}"
    initial_delay_sec = 420
  }
}


resource "google_compute_region_autoscaler" "foobar" {
  name   = "my-autoscaler"
  region = "us-central1"
  target = "${google_compute_region_instance_group_manager.2ndgroup.self_link}"

  autoscaling_policy {
    max_replicas    = 5
    min_replicas    = 3
    cooldown_period = 180

    cpu_utilization {
      target = 0.7
    }
  }
}