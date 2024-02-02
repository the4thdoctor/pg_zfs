# resource "google_storage_bucket" "kd_testing_tfstate" {
# name     = "${var.gcp_bucket}"
# location = "${var.gcp_region}"
# force_destroy = false
# storage_class = "STANDARD"
#   versioning {
#     enabled = true
#   }
# }