output "bastion-ip-address" {
  value = "${google_compute_address.bastion-ip-address.address}"
}