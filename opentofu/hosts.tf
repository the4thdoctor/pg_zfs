resource "google_compute_instance" "bastion_instance" {
  name         = var.bastion_name
  machine_type = "e2-small"
  tags         = ["bastion"]

  boot_disk {
    initialize_params {
      image = "rocky-linux-cloud/rocky-linux-9"
    }
  }

  network_interface {
    network = google_compute_network.vpc_network.name
    access_config {
      nat_ip = google_compute_address.default_standard.address
      network_tier = "STANDARD"
    }
  }

  metadata = {
   ssh-keys = "${var.ssh_user}:${file("${var.HOME}/${var.ssh_key}.pub")}"
 }
}

resource "google_compute_instance" "prometheus_instance" {
  name         = var.prometheus_name
  machine_type = "e2-small"
  tags         = ["prometheus"]

  boot_disk {
    initialize_params {
      image = "rocky-linux-cloud/rocky-linux-9"
    }
  }

  network_interface {
    network = google_compute_network.vpc_network.name

  }

  metadata = {
   ssh-keys = "${var.ssh_user}:${file("${var.HOME}/${var.ssh_key}.pub")}"
 }
}

resource "google_compute_instance" "postgresql_instance" {
  name         = "${var.postgresql_node_prefix}${count.index}"
  machine_type = "e2-highmem-8"
  #machine_type = "e2-small"
  tags         = ["postgresql"]
  count = var.postgresql_node_count
    labels = { 
    postgresql-node = count.index,
  } 
  boot_disk {
    initialize_params {
      image = "rocky-linux-cloud/rocky-linux-9"
    }
  }
  attached_disk {
  source = "${google_compute_disk.pg_ext4_hdd[count.index].name}"
  device_name = "${google_compute_disk.pg_ext4_hdd[count.index].name}"
    }
  attached_disk {
  source = "${google_compute_disk.pg_zfs_hdd[count.index].name}"
  device_name = "${google_compute_disk.pg_zfs_hdd[count.index].name}"
  }
  attached_disk {
  source = "${google_compute_disk.pg_zil_ssd[count.index].name}"
  device_name = "${google_compute_disk.pg_zil_ssd[count.index].name}"
  }
  attached_disk {
  source = "${google_compute_disk.pg_data_hdd[count.index].name}"
  device_name = "${google_compute_disk.pg_data_hdd[count.index].name}"
  }
  
  network_interface {
    network = google_compute_network.vpc_network.name

  }

  metadata = {
   ssh-keys = "${var.ssh_user}:${file("${var.HOME}/${var.ssh_key}.pub")}"
 }
}
