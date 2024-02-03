resource "google_compute_instance" "bastion_instance" {
  name         = var.bastion_name
  machine_type = "f1-micro"
  tags         = ["bastion"]

  boot_disk {
    initialize_params {
      image = "rocky-linux-cloud/rocky-linux-9"
    }
  }

  network_interface {
    network = google_compute_network.vpc_network.name
    access_config {
    }
  }

  metadata = {
   ssh-keys = "${var.ssh_user}:${file("${var.HOME}/${var.ssh_key}.pub")}"
 }
}


resource "google_compute_instance" "postgresql_instance" {
  name         = "${var.postgresql_node_prefix}${count.index}"
  machine_type = "e2-small"
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

  network_interface {
    network = google_compute_network.vpc_network.name

  }

  metadata = {
   ssh-keys = "${var.ssh_user}:${file("${var.HOME}/${var.ssh_key}.pub")}"
 }
}
