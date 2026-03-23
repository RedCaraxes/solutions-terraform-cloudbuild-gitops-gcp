# Esto obtiene el NÚMERO del proyecto (ej: 906041062473)
data "google_project" "invitado" {
  project_id = var.service_project_id
}

resource "google_compute_shared_vpc_service_project" "service_project" {
  host_project    = var.host_project_id
  service_project = var.service_project_id
}

resource "google_compute_subnetwork_iam_member" "network_user" {
  project    = var.host_project_id
  region     = var.region
  subnetwork = var.subnet_name
  role       = "roles/compute.networkUser"

  # CAMBIO CLAVE: Usamos .number en lugar de .id
  member = "serviceAccount:${data.google_project.invitado.number}@cloudservices.gserviceaccount.com"

  depends_on = [google_compute_shared_vpc_service_project.service_project]
}