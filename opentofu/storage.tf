resource "google_compute_disk" "pg_data_hdd" {
  name  = "pg-data${count.index}"
  count = var.postgresql_node_count
  type  = "pd-standard"
  zone  = "${var.gcp_region}-${var.gcp_zone}"
  size  = 10
  physical_block_size_bytes = 4096
}
