resource "google_compute_instance" "bastion" {
  name = "${var.bastion_name}"
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
    network = "${var.student_name}-vpc"
    subnetwork = "${var.public_subnetwork}"
    access_config = {}
  }

  tags = "${var.bastion_tags}"
}