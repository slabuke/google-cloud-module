#gcp-cloud-module
##task 3 by Vitali Andrushkevich

I have recently completed all labs from google:

1. load balancers in Google Cloud Platform

![Image alt](https://github.com/MNT-Lab/google-cloud-module/blob/vandrushkevich/Day3/img/Load-balancer-task1.png)
![Image alt](https://github.com/MNT-Lab/google-cloud-module/blob/vandrushkevich/Day3/img/cluster-gcp-node1.png)
![Image alt](https://github.com/MNT-Lab/google-cloud-module/blob/vandrushkevich/Day3/img/lb-details.png)
![Image alt](https://github.com/MNT-Lab/google-cloud-module/blob/vandrushkevich/Day3/img/lb-monitor.png)
![Image alt](https://github.com/MNT-Lab/google-cloud-module/blob/vandrushkevich/Day3/img/task1-complete.png)

2. Networking 101.

![Image alt](https://github.com/MNT-Lab/google-cloud-module/blob/vandrushkevich/Day3/img/verify-web-functionality1.png)
![Image alt](https://github.com/MNT-Lab/google-cloud-module/blob/vandrushkevich/Day3/img/verify-functionality-2.png)
![Image alt](https://github.com/MNT-Lab/google-cloud-module/blob/vandrushkevich/Day3/img/done-02.png)


3. Networking 102.

![Image alt](https://github.com/MNT-Lab/google-cloud-module/blob/vandrushkevich/Day3/img/Screenshot%20from%202020-02-18%2019-15-52.png)
![Image alt](https://github.com/MNT-Lab/google-cloud-module/blob/vandrushkevich/Day3/img/Screenshot%20from%202020-02-18%2019-15-09.png)
![Image alt](https://github.com/MNT-Lab/google-cloud-module/blob/vandrushkevich/Day3/img/Screenshot%20from%202020-02-18%2019-21-27.png)

4. Custom network.

![Image alt](https://github.com/MNT-Lab/google-cloud-module/blob/vandrushkevich/Day3/img/4-3.png)
![Image alt](https://github.com/MNT-Lab/google-cloud-module/blob/vandrushkevich/Day3/img/4-firewall.png)
![Image alt](https://github.com/MNT-Lab/google-cloud-module/blob/vandrushkevich/Day3/img/4-ping.png)

5. Create Create network configuration via terraform.

Resources should be used:

1) google_compute_network (to create network) https://www.terraform.io/docs/providers/google/r/compute_network.html

```tf
resource "google_compute_network" "vpc_network" {
  name                    = "vandrushkevich-vpc"
  description             = "my network"
  auto_create_subnetworks = "false"
  routing_mode            = "GLOBAL"
}
```

2) google_compute_firewall (to create rules for external (allow 80,22) /internal access (allow 0-65535) ) https://www.terraform.io/docs/providers/google/r/compute_firewall.html

```tf
resource "google_compute_firewall" "external-allow" {
  name        = "vandrushkevich-external"
  description = "Allow external 80 port"
  network     = "${google_compute_network.vpc_network.name}"

  allow {
    protocol = "tcp"
    ports    = ["80", "22"]
  }
  target_tags = ["http-server", "ssh"]
}

resource "google_compute_firewall" "allow-internal" {
  name    = "vandrushekvich-internal"
  network = "${google_compute_network.vpc_network.name}"
  
  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }
  allow {
    protocol = "udp"
    ports    = ["0-65535"]
    
  }
  direction = "EGRESS"

}

```

3) google_compute_subnetwork https://www.terraform.io/docs/providers/google/r/compute_subnetwork.html 
ranges:(Public range: 10.”${student_IDnum}”.1.0/24, Private range: 10.”${student_IDnum}”.2.0/24)

```tf
resource "google_compute_subnetwork" "subnetpriv" {
  name          = "vandrushkevich-private"
  ip_cidr_range = "10.14.2.0/24"
  region        = "us-central1"
  network       = "${google_compute_network.vpc_network.name}"
  description = "private subnetwork"
}

resource "google_compute_subnetwork" "subnetpub" {
  name          = "vandrushkevich-public"
  ip_cidr_range = "10.14.1.0/24"
  region        = "us-central1"
  network       = "${google_compute_network.vpc_network.name}"
  description   = "public subnetwork"
}
```

4) google_compute_instance https://www.terraform.io/docs/providers/google/r/compute_instance.html
For base i have used a script that i use in previos task (debian base)
[main.tf][1]

[variables.tf][2]


[1]: https://github.com/MNT-Lab/google-cloud-module/blob/vandrushkevich/Day3/main.tf
[2]: https://github.com/MNT-Lab/google-cloud-module/blob/vandrushkevich/Day3/variables.tf
