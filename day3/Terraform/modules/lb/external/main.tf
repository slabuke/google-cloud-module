# Using GCP LB-HTTP(s) module

module "gce-lb-http" {
  version           = "1.0.10"
  source            = "GoogleCloudPlatform/lb-http/google"
  name              = "${var.name}"
  target_tags       = "${var.target_tags}"
  backends          = {
    "0" = [
      { group = "${var.ign}" }
    ],
  }
  backend_params = ["/,http,80,10"]
}