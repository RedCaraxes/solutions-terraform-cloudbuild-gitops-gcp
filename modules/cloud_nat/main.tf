resource "google_compute_router_nat" "nat_public" {
  project = var.project_id
  region  = var.region
  name    = var.nat_name
  router  = var.router_name

  # Opción recomendada para Shared VPC: asignar IPs automáticamente
  nat_ip_allocate_option = var.nat_ip_allocate_option

  # IMPORTANTE: Esto permite que TODAS las subredes de la Shared VPC 
  # en esta región usen el NAT, incluyendo las de proyectos de servicio.
  source_subnetwork_ip_ranges_to_nat = var.source_subnetwork_ip_ranges_to_nat

  dynamic "log_config" {
    for_each = var.enable_logging ? [1] : []
    content {
      enable = true
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

  # Configuración de timeout por defecto optimizada para v7.x
  tcp_established_idle_timeout_sec = var.tcp_established_idle_timeout_sec
  tcp_transitory_idle_timeout_sec  = var.tcp_transitory_idle_timeout_sec
}