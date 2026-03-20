resource "google_compute_router_nat" "nat" {
  project = var.project_id
  region  = var.region
  name    = var.nat_name
  router  = var.router_name

  nat_ip_allocate_option             = var.nat_ip_allocate_option
  source_subnetwork_ip_ranges_to_nat = var.source_subnetwork_ip_ranges_to_nat

  dynamic "log_config" {
    for_each = var.enable_logging ? [1] : []
    content {
      enable = var.enable_logging
      filter = var.log_filter
    }
  }

  dynamic "subnetwork" {
    for_each = var.subnetworks
    content {
      name                     = subnetwork.value.name
      source_ip_ranges_to_nat  = subnetwork.value.source_ip_ranges_to_nat
      secondary_ip_range_names = lookup(subnetwork.value, "secondary_ip_range_names", null)
    }
  }

  tcp_established_idle_timeout_sec = var.tcp_established_idle_timeout_sec
  tcp_transitory_idle_timeout_sec  = var.tcp_transitory_idle_timeout_sec
}