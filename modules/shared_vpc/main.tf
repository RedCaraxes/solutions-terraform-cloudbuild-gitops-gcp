resource "google_compute_shared_vpc_service_project" "service_project" {
  host_project    = var.host_project_id
  service_project = var.service_project_id
}

resource "google_compute_subnetwork_iam_member" "network_user" {
  project    = var.host_project_id
  region     = var.region
  subnetwork = var.subnet_name
  role       = "roles/compute.networkUser"

  # Usamos var.service_project_num
  member     = "serviceAccount:${var.service_project_num}@cloudservices.gserviceaccount.com"

  depends_on = [google_compute_shared_vpc_service_project.service_project]
}