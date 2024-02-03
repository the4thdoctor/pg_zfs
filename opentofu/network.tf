resource "google_compute_network" "vpc_network" {
  name = "kd-testing-network"
}

resource "google_compute_subnetwork" "vpc_subnet" {
  name          = "kd-testing-subnetwork"
  network       = google_compute_network.vpc_network.id
  ip_cidr_range = "10.0.0.0/16"
  
}

resource "google_compute_router" "router" {
  name    = "kd-testing-router"
  region  = google_compute_subnetwork.vpc_subnet.region
  network = google_compute_network.vpc_network.id

  bgp {
    asn = 64514
  }
}

resource "google_compute_router_nat" "nat" {
  name                               = "kd-testing-router-nat"
  router                             = google_compute_router.router.name
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
}

resource "google_compute_firewall" "firewall_ssh" {
  name    = "firewall-ssh"
   network = google_compute_network.vpc_network.name
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags = ["bastion","postgresql"]
}

resource "google_compute_firewall" "firewall_nodes" {
  name    = "firewall-nodes"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["22","5432"]
  }

  source_tags = ["bastion"]
}


