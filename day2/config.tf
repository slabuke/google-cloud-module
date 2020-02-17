resource "google_compute_instance" "vm_instance" {
  name         = "${var.name}"
  machine_type = "${var.machine_type}"
  zone = "${var.zone}"

  boot_disk {
    initialize_params {
      image = "${var.image}"
    size = "${var.size}"
    type = "${var.type}"
    }
    
  }

  network_interface {
    network       = "${var.network}"
    access_config {}
   
 
 }
 

   metadata_startup_script = "${var.script}"

   labels {
	servertype = "${var.servertype}"
	osfamily = "${var.osfamily}"
	wayofinstallation = "${var.wayofinstallation}" 
	  }
   deletion_protection = "${var.deletion_protection}"

   tags="${var.tags}"

 }


