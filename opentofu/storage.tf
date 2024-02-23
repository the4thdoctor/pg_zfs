resource "google_compute_disk" "pg_ext4_hdd" {
  name  = "${var.pg_ext4_hdd}${count.index}"
  count = var.postgresql_node_count
  type  = "pd-standard"
  zone  = "${var.gcp_region}-${var.gcp_zone}"
  size  = 11
  physical_block_size_bytes = 4096
}

resource "google_compute_disk" "pg_zfs_hdd" {
  name  = "pg-zfs-hdd${count.index}"
  count = var.postgresql_node_count
  type  = "pd-standard"
  zone  = "${var.gcp_region}-${var.gcp_zone}"
  size  = 11
  physical_block_size_bytes = 4096
}

resource "google_compute_disk" "pg_zil_ssd" {
  name  = "pg-zil-ssd${count.index}"
  count = var.postgresql_node_count
  type  = "pd-ssd"
  zone  = "${var.gcp_region}-${var.gcp_zone}"
  size  = 11
  physical_block_size_bytes = 4096
}