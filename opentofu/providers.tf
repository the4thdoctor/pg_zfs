terraform {
  required_providers {
    google = {
      source  = "google"
      version = ">=3.53.0"
    }
    local = {
      source = "local"
      version = ">=2.1.0"
    }
  }
}

provider "google" {
  credentials = file(var.credential_file)

  project = "${var.gcp_project}"
  region  = "${var.gcp_region}"
  zone    = "${var.gcp_region}-${var.gcp_zone}"
}


