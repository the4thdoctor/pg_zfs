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
  content = templatefile("templates/ssh.bastion.tmpl",
    {
     bastion_ip = google_compute_instance.bastion_instance.network_interface.0.access_config.0.nat_ip,
     bastion_name = google_compute_instance.bastion_instance.name
     prometheus_name = google_compute_instance.prometheus_instance.name
     ssh_user = var.ssh_user
     ssh_key = "${var.HOME}/${var.ssh_key}"
    }
  )
  filename = "${var.HOME}/${var.ssh_bastion_conf}"
}

resource "local_file" "ssh_nodes_config" {
  content = templatefile("templates/ssh.nodes.tmpl",
    {
     bastion_name = google_compute_instance.bastion_instance.name
     ssh_user = var.ssh_user
     ssh_key = "${var.HOME}/${var.ssh_key}"
     postgresql_node_prefix = var.postgresql_node_prefix
     postgresql_nodes = range(var.postgresql_node_count)
    }
  )
  filename = "${var.HOME}/${var.ssh_nodes_conf}"
}

resource "local_file" "ansible_inventory" {
  content = templatefile("templates/ansible_hostfile.tmpl",
    {
     postgresql_node_name = google_compute_instance.postgresql_instance.*.name
     postgresql_node_prefix = var.postgresql_node_prefix
     postgresql_nodes = range(var.postgresql_node_count)
     ssh_user = var.ssh_user
     ssh_key = "${var.HOME}/${var.ssh_key}"
     pg_ext4_hdd = "${var.pg_ext4_hdd}"
     pg_zfs_hdd = "${var.pg_zfs_hdd}"
     pg_zil_ssd = "${var.pg_zil_ssd}"
     pg_data_hdd = "${var.pg_data_hdd}"
     prometheus_name = google_compute_instance.prometheus_instance.name
    }
  )
  filename = "../ansible/inventory/gcp/hosts"
}