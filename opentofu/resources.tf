# resource "google_storage_bucket" "kd_testing_tfstate" {
# name     = "${var.gcp_bucket}"
# location = "${var.gcp_region}"
# force_destroy = false
# storage_class = "STANDARD"
#   versioning {
#     enabled = true
#   }
# }

resource "local_file" "ssh_bastion_config" {
  content = templatefile("ssh.bastion.tmpl",
    {
     bastion_ip = google_compute_instance.bastion_instance.network_interface.0.access_config.0.nat_ip,
     bastion_name = google_compute_instance.bastion_instance.name
     ssh_user = var.ssh_user
     ssh_key = "${var.HOME}/${var.ssh_key}"
    }
  )
  filename = "${var.HOME}/${var.ssh_conf}"
}