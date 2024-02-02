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
