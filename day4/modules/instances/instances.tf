variable "network"{}
variable "privatsub"{}
variable "publicsub"{}

resource "google_compute_instance_template" "nginx" {
  name = "nginx"
  region = "${var.region[0]}"
  machine_type = "${var.mtype[2]}"
  
  
  tags = ["http-server","ssh"]

  labels {
    servertype = "${var.label[0]}"
    osfamily= "${var.label[2]}"
    wayofinstallation= "${var.label[3]}"
  }

  disk {
    source_image = "${var.image[1]}"
    auto_delete  = true
    boot         = true
  }

  network_interface {
    network = "${var.network}"
    subnetwork = "${var.publicsub}"
    access_config {
      // Ephemeral IP
    }
  }

metadata_startup_script = <<SCRIPT
 sudo yum update -y
 sudo yum install nginx -y
 sudo echo "<h1>Hello from Maxim Filipovich!</h1>" > /usr/share/nginx/html/index.html
 sudo systemctl enable nginx
 sudo systemctl start nginx
 SCRIPT
}

resource "google_compute_instance_template" "db" {
  name = "db"
  region = "${var.region[0]}"
  machine_type = "${var.mtype[2]}"
  can_ip_forward = true
  
  
  tags = ["http-server","ssh"]

  labels {
    servertype = "${var.label[0]}"
    osfamily= "${var.label[2]}"
    wayofinstallation= "${var.label[3]}"
  }

  disk {
    source_image = "${var.image[1]}"
    auto_delete  = true
    boot         = true
  }

  network_interface {
    network = "${var.network}"
    subnetwork = "${var.privatsub}"
  }

metadata_startup_script = <<SCRIPT
 sudo yum update -y
 sudo yum install nginx -y
 sudo echo "<h1>Hello from $HOSTNAME</h1>" > /usr/share/nginx/html/index.html
 sudo systemctl enable nginx
 sudo systemctl start nginx
 SCRIPT
}

