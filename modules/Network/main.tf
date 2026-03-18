resource "google_compute_subnetwork" "network-with-private-secondary-ip-ranges" {
  name          = var.subnetwork_name
  ip_cidr_range = var.ip_cidr_range
  region        = var.location
  network       = google_compute_network.custom-test.id
  secondary_ip_range {
    range_name    = var.secondary_ip_range_name
    ip_cidr_range = var.secondary_ip_cidr_range
  }
}

resource "google_compute_network" "network_vpc" {
  name                    = var.network_name
  auto_create_subnetworks = var.auto_create_subnetworks
}
