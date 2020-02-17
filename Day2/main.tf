provider "google" {
  credentials = "${file("/home/student/ter/.andrei-leanovich-84-02ef3fc6ad58.json")}"

  project = "andrei-leanovich-84"

  region = "${var.region}"
  zone   = "${var.zone}"
}

resource "google_compute_instance" "terraform" {
  name                = "nginx-terraform"
  machine_type        = "custom-1-4096"
  zone                = "${var.zone}"
  deletion_protection = false

  labels = {
    server-type       = "nginx-server"
    osfamily          = "redhat"
    wayofinstallation = "terraform"
  }

  tags = ["http-server", "https-server"]

  boot_disk {
    initialize_params {
      size  = "${var.disk_size_gb}"
      image = "centos-7-v20200205"
      type  = "pd-ssd"
    }
  }

  scratch_disk {
    interface = "SCSI"
  }

  network_interface {
    network = "default"

    access_config {}
  }

  #  metadata = {
  #    userdata = "script.sh"
  #  }
  lifecycle {
    ignore_changes = ["attached_disk"]
  }

  metadata_startup_script = "#!/bin/bash; yum update; yum install -y nginx; sudo systemctl start nginx; sudo systemctl enable nginx"
}

resource "google_compute_disk" "attached_disk" {
  name = "attached-disk"
  type = "pd-ssd"
  zone = "${var.zone}"
  size = "10"
}

resource "google_compute_attached_disk" "nginx-terraform" {
  disk     = "${google_compute_disk.attached_disk.self_link}"
  instance = "${google_compute_instance.terraform.self_link}"
}
