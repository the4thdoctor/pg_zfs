terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~>3.53.0"
    }
    local = {
      source = "hashicorp/local"
      version = "~>2.1.0"
    }
  }
}

provider "google" {
  credentials = file(var.credential_file)

  project = "${var.gcp_project}"
  region  = "${var.gcp_region}"
  zone    = "${var.gcp_region}-${var.gcp_zone}"
}


# resource "google_storage_bucket" "pg_arpa_piemonte_tfstate" {
# name     = "${var.gcp_bucket}"
# location = "${var.gcp_region}"
# force_destroy = false
# storage_class = "STANDARD"
#   versioning {
#     enabled = true
#   }
# }