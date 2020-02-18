resource "google_compute_instance" "nginx-terraform" {
  name         = "${var.instance_name}"
  machine_type = "${var.machine_type}"
  zone         = "${var.zone}"
  tags 	       = ["${var.http}","${var.https}"]
  description  = "Simple machine"

 boot_disk {
   initialize_params {
	image = "${var.image_project}/${var.image_family}"
	size  = "${var.disk_size_gb}"
	type  = "${var.disk_type}"
   }
 }


 metadata_startup_script = "sudo apt-get -y update; sudo apt-get -y install nginx; systemctl enable nginx; systemctl start nginx; echo 'Hello from Pavel Karunas' | sudo tee /var/www/html/index.html"

 network_interface {
    network       = "${var.network_name}"
    subnetwork    = "${var.net1}"
    access_config = {}
  
  }

}

