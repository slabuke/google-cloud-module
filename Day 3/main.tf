provider "google" {
  credentials = "${file("dev-001-project-a8b4975949ab.json")}"
  project     = "${var.Project_name}"
  region      = "${var.RegionAndZone}"
}

resource "google_compute_instance" "nginx-terraform" {
   count         = "${var.Instance_count}"
   name          = "${var.Instance_name}"
   zone          = "${var.RegionAndZone}"
   machine_type  = "${var.Type_Machine}"

   depends_on = ["google_compute_subnetwork.public-sub"]

   tags = ["http-server", "https-server"]

   labels = {
     servertype        = "${var.Server_Type}"
     osfamily          = "${var.OS_Family}"
     wayofinstallation = "${var.WayOfInstallation}"
}

   boot_disk {
     initialize_params {
        size  = "${var.Size_Disk}"
        type  = "${var.Type_Disk}"
        image = "${var.Image_OS}"
          }
         }

          network_interface {
            network    = "${var.Student_name}-vpc"
            subnetwork = "sub-${var.Student_name}-public"

              access_config {
                // Ephemeral IP
                }
              }

              metadata_startup_script = <<EOF
              sudo -i
              apt-get -y update
              apt-get -y install nginx
              systemctl start nginx
              systemctl enable nginx
              echo 'Hello from Kirill_Baravoy!' > /var/www/html/index.html
EOF

}
