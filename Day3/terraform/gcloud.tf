provider "google" {
  credentials = "${file("artsemiyoursh-day1proj-611e57f2fcb9.json")}"
  project     = "${var.project}"
  region      = "${var.region}"
}

data "google_compute_zones" "available" {}

resource "google_compute_instance" "nginx-3" {
 name         = "${var.vm-name}"
 zone         = "${var.zone}"
 network_interface {
    network = "${var.network}"
    subnetwork = "sub-pub-${var.network}"
    access_config {
      
    }
 }
 machine_type = "${var.mtype}"
 deletion_protection = "${var.protection}"
 labels = {
    servertype = "${var.lab-servertype}"
    osfamily= "${var.lab-osfamily}"
    wayofinstallation= "${var.lab-wayofinstallation}"
  }
 tags = ["http-server","https-server"]
 boot_disk {
   initialize_params {
     type = "${var.disktype}"
     image = "${var.image}"
     size = "${var.disksize}"
   }
 }
 lifecycle {
    
  }
 metadata_startup_script = "${var.script}"

}
