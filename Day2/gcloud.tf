provider "google" {
  credentials = "${file("artsemiyoursh-day1proj-611e57f2fcb9.json")}"
  project     = "${var.project}"
  region      = "${var.region}"
}

resource "google_compute_instance" "nginx-terraform" {
 name         = "${var.vm-name}"
 zone         = "${var.zone}"
 network_interface {
    network = "${var.network}"
    access_config {
      
    }
 }
 machine_type = "${var.memory}"
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
    ignore_changes = ["attached_disk"]
  }
 metadata_startup_script = "${var.script}"

}
