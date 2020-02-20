output "network" {
    value = "${google_compute_network.maxim-vpc.self_link}"
}

output "publicsub" {
    value = "${google_compute_subnetwork.public-sub.self_link}"
}

output "privatsub" {
    value = "${google_compute_subnetwork.private-sub.self_link}"
}

output "internalfw" {
    value = "${google_compute_firewall.internal-firewall.self_link}"
}

output "httpop" {
    value = "${google_compute_firewall.http-open.self_link}"
}

output "sshop" {
    value = "${google_compute_firewall.ssh-open.self_link}"
}

output "telnetop" {
    value = "${google_compute_firewall.telnet-open.self_link}"
}
