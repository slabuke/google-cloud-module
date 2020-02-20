module "gce-lb-http" {
  version           = "1.0.10"
  source            = "GoogleCloudPlatform/lb-http/google"
  name              = "group-http-lb"
  target_tags       = ["web"]
  backends          = {
    "0" = [
      { group = "${var.instance-group_name}" }
    ],
  }
  backend_params = ["/,http,80,10"]
}

variable "instance-group_name" {}