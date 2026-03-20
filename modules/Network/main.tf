resource "google_compute_subnetwork" "subnets" {
  for_each = var.subnets

  name          = each.key
  ip_cidr_range = each.value.ip_cidr_range
  region        = var.value.location
  network       = google_compute_network.network_vpc.id

  dynamic "secondary_ip_range" {
    for_each = each.value.secondary_ip_ranges
    content {
      range_name    = secondary_ip_range.key
      ip_cidr_range = secondary_ip_range.value
    }
  }
}

resource "google_compute_network" "network_vpc" {
  name                    = var.network_name
  auto_create_subnetworks = var.auto_create_subnetworks
}
