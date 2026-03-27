resource "google_composer_environment" "this" {
  name    = var.name
  region  = var.region
  project = var.project

  config {
    enable_private_builds_only = var.enable_private_builds_only
    enable_private_environment = var.enable_private_environment
    environment_size           = var.environment_size

    data_retention_config {
      airflow_metadata_retention_config {
        retention_mode = var.retention_mode
      }
    }

    maintenance_window {
      start_time = var.maintenance_start_time
      end_time   = var.maintenance_end_time
      recurrence = var.maintenance_recurrence
    }

    software_config {
      image_version           = var.image_version
      env_variables           = var.env_variables
      pypi_packages           = var.pypi_packages
      web_server_plugins_mode = var.web_server_plugins_mode

      cloud_data_lineage_integration {
        enabled = var.data_lineage_enabled
      }
    }

    web_server_network_access_control {
      dynamic "allowed_ip_range" {
        for_each = var.allowed_ip_ranges
        content {
          value       = allowed_ip_range.value.value
          description = allowed_ip_range.value.description
        }
      }
    }

    workloads_config {
      scheduler {
        cpu        = var.scheduler.cpu
        memory_gb  = var.scheduler.memory_gb
        storage_gb = var.scheduler.storage_gb
        count      = var.scheduler.count
      }

      triggerer {
        cpu       = var.triggerer.cpu
        memory_gb = var.triggerer.memory_gb
        count     = var.triggerer.count
      }

      dag_processor {
        cpu        = var.dag_processor.cpu
        memory_gb  = var.dag_processor.memory_gb
        storage_gb = var.dag_processor.storage_gb
        count      = var.dag_processor.count
      }

      web_server {
        cpu        = var.web_server.cpu
        memory_gb  = var.web_server.memory_gb
        storage_gb = var.web_server.storage_gb
      }

      worker {
        cpu        = var.worker.cpu
        memory_gb  = var.worker.memory_gb
        storage_gb = var.worker.storage_gb
        min_count  = var.worker.min_count
        max_count  = var.worker.max_count
      }
    }

    node_config {
      network                           = var.network
      subnetwork                        = var.subnetwork
      service_account                   = google_service_account.composer_sa.email
      composer_internal_ipv4_cidr_block = var.composer_internal_ipv4_cidr_block
      enable_ip_masq_agent              = var.enable_ip_masq_agent
      tags                              = var.tags
    }

    resilience_mode = var.resilience_mode
  }

  storage_config {
    bucket = var.bucket
  }
}

resource "google_service_account" "composer_sa" {
  account_id   = var.sa_account_id
  display_name = var.sa_display_name
}

resource "google_project_iam_member" "composer_worker" {
  project = var.project
  role    = var.composer_worker_role
  member  = "serviceAccount:${google_service_account.composer_sa.email}"
}