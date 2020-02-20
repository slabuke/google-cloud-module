
resource "google_compute_instance" "bastion" {
 name         = "bastion"
 zone         = "us-central1-c"
 network_interface {
    network = "day4-network"
    subnetwork = "publicsubnetwork"
    access_config {
    }
 }
 machine_type = "n1-standard-1"
  labels = {
  }
 tags = ["web"]
 boot_disk {
   initialize_params {
     
     image = "centos-cloud/centos-7"
     
   }
 }
 lifecycle {
    
  }
}
