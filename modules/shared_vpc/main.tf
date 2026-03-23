resource "google_compute_shared_vpc_service_project" "service_project" {
  host_project    = var.host_project_id
  service_project = var.service_project_id
  
  depends_on = [google_compute_shared_vpc_host_project.host]
}

# 3. Dar permiso en UNA Subred específica para que el invitado pueda usarla
resource "google_compute_subnetwork_iam_member" "network_user" {
  project    = var.host_project_id
  region     = var.region
  subnetwork = var.subnet_name
  role       = "roles/compute.networkUser"

  # El "invitado" suele ser la cuenta de Google APIs del proyecto de servicio
  member = "serviceAccount:${var.service_project_id}@cloudservices.gserviceaccount.com"

  # Esperamos a que el proyecto esté vinculado antes de dar permisos
  depends_on = [google_compute_shared_vpc_service_project.service_project]
}