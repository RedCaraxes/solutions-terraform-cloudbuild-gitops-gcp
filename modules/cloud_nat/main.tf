resource "google_compute_router_nat" "nat" {
  project = var.project_id
  region  = var.region
  name    = var.nat_name
  router  = var.router_name

  # Opción recomendada para Shared VPC: asignar IPs automáticamente
  nat_ip_allocate_option             = "AUTO_ONLY"
  
  # IMPORTANTE: Esto permite que TODAS las subredes de la Shared VPC 
  # en esta región usen el NAT, incluyendo las de proyectos de servicio.
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  log_config {
    enable = true
    filter = var.log_filter
  }

  # Configuración de timeout por defecto optimizada para v7.x
  tcp_established_idle_timeout_sec = 1200
  tcp_transitory_idle_timeout_sec  = 30
}