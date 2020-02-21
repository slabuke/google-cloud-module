provider "google" {
  credentials = "${file("dev-001-project-a8b4975949ab.json")}"
  project     = "${var.Project_name}"
  region      = "${var.RegionAndZone}"
}

resource "google_compute_instance" "nginx-terraform" {
   name         = "${var.Instance_name}"
   zone         = "${var.RegionAndZone}"
   machine_type = "${var.Type_Machine}"

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
            network = "default"
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

# Task 2
resource "google_compute_disk" "nginx-gcp-ui-disk3" {
  name   = "nginx-gcp-ui-disk3"
  zone   = "${var.RegionAndZone}"
  size   = "10"
}

resource "google_compute_attached_disk" "default" {
  disk     = "${google_compute_disk.nginx-gcp-ui-disk3.self_link}"
  instance = "${google_compute_instance.nginx-terraform.self_link}"
}
