provider "google" {
  credentials = "${file("dev-001-project-a8b4975949ab.json")}"
  project     = "${var.Project_name}"
  region      = "${var.RegionAndZone}"
}

resource "google_compute_instance" "nginx-classwork-terraform" {
   count        = "${var.instance_count}"
   name         = "${var.Instance_name}-${count.index}"
   zone         = "${var.RegionAndZone}"
   machine_type = "${var.Type_Machine}"

   timeouts {
     delete = "40m"
   }

   boot_disk {
     initialize_params {
        size  = "${var.Size_Disk}"
        type  = "${var.Type_Disk}"
        image = "${var.Image_OS}"
          }
         }


         tags = ["http-server", "https-server"]
         metadata_startup_script = "sudo yum -y update && sudo yum -y install nginx && sudo systemctl enable nginx && sudo systemctl start nginx"
         deletion_protection     = true

          network_interface {
            network = "${var.Network}"
              access_config {
                // Ephemeral IP
                }
              }

            labels = {
              servertype        = "${var.Server_Type}"
              osfamily          = "${var.OS_Family}"
              wayofinstallation = "${var.WayOfInstallation}"
  }
}
