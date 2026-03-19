resource "google_compute_router" "router" {
  name    = var.router_name
  network = var.network_id
  region  = var.region
  project = var.project_id

  bgp {
    asn = var.asn
  }
}

output "router_name" {
  value = google_compute_router.router.name
}