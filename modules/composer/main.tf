resource "google_composer_environment" "env" {
  name    = var.name
  project = var.project
  region  = var.region

  config {
    environment_size = var.env_size

    software_config {
      image_version = var.image_version
    }

    node_config {
      network         = var.network
      subnetwork      = var.subnetwork
      service_account = var.service_account
    }
  }
}