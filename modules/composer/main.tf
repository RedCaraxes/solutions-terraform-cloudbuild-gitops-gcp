resource "google_composer_environment" "test" {
  name   = "example-composer-env-tf-c3"
  region = "us-central1"
  project = "rs-web-tier"
  config {
    enable_private_builds_only = false
    enable_private_environment = true
    environment_size = "ENVIRONMENT_SIZE_SMALL"
    data_retention_config {
      airflow_metadata_retention_config {
        retention_mode = "RETENTION_MODE_DISABLED"
      }
    }
    
    maintenance_window {
      end_time   = "2025-12-15T09:00:00Z"
      recurrence = "FREQ=WEEKLY;BYDAY=FR,SA,SU"
      start_time = "2025-12-15T05:00:00Z"
    }

    software_config {
      env_variables            = {} 
      image_version            = "composer-3-airflow-2.9.3"
      pypi_packages            = {} 
      web_server_plugins_mode  = "ENABLED" 
      cloud_data_lineage_integration {
enabled = true 
                }
    }

    web_server_network_access_control {
      allowed_ip_range {
        description = "Allows access from all IPv6 addresses (default value)"
        value       = "0.0.0.0/0"
                }
      allowed_ip_range {
                  description = "Allows access from all IPv6 addresses (default value)"
                  value       = "::0/0"
                }
            }

    workloads_config {
      scheduler {
        cpu        = 0.5
        memory_gb  = 2
        storage_gb = 1
        count      = 1
      }
      triggerer {
        cpu        = 0.5
        memory_gb  = 1
        count      = 1
      }
      dag_processor {
        cpu        = 1
        memory_gb  = 2
        storage_gb = 1
        count      = 1
      }
      web_server {
        cpu        = 0.5
        memory_gb  = 2
        storage_gb = 1
      }
      worker {
        cpu = 0.5
        memory_gb  = 2
        storage_gb = 1
        min_count  = 1
        max_count  = 3
      }

    }
    

    node_config {
composer_internal_ipv4_cidr_block = "100.64.128.0/20"
enable_ip_masq_agent              = false
network                           = "projects/rs-prd-orgnet-host-net-83ba/global/networks/ue4-orgnet-prd-net-dev-vpc-001"
service_account                   = "sa-nprd-dlk-dd-trsv-cc@rs-nprd-dlk-dd-trsv-ede4.iam.gserviceaccount.com"
subnetwork                        = "projects/rs-prd-orgnet-host-net-83ba/regions/us-east4/subnetworks/ue4-orgnet-prd-net-dev-sbn-003"
tags                              = []

            }

    resilience_mode = "STANDARD_RESILIENCE"

    } 
        storage_config {
      bucket = "assaklj-asd54"
    }
  }

resource "google_service_account" "test" {
  account_id   = "composer-env-account"
  display_name = "Test Service Account for Composer Environment"
}

resource "google_project_iam_member" "composer-worker" {
  project = "your-project-id"
  role    = "roles/composer.worker"
  member  = "serviceAccount:${google_service_account.test.email}"
}