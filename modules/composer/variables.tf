variable "name" { type = string }
variable "region" { type = string }
variable "project" { type = string }

variable "enable_private_builds_only" { type = bool }
variable "enable_private_environment" { type = bool }
variable "environment_size" { type = string }

variable "retention_mode" { type = string }

variable "maintenance_start_time" { type = string }
variable "maintenance_end_time" { type = string }
variable "maintenance_recurrence" { type = string }

variable "image_version" { type = string }
variable "env_variables" { type = map(string) }
variable "pypi_packages" { type = map(string) }
variable "web_server_plugins_mode" { type = string }
variable "data_lineage_enabled" { type = bool }

variable "allowed_ip_ranges" {
  type = list(object({
    value       = string
    description = string
  }))
}

# Workloads
variable "scheduler" {
  type = object({
    cpu        = number
    memory_gb  = number
    storage_gb = number
    count      = number
  })
}

variable "triggerer" {
  type = object({
    cpu       = number
    memory_gb = number
    count     = number
  })
}

variable "dag_processor" {
  type = object({
    cpu        = number
    memory_gb  = number
    storage_gb = number
    count      = number
  })
}

variable "web_server" {
  type = object({
    cpu        = number
    memory_gb  = number
    storage_gb = number
  })
}

variable "worker" {
  type = object({
    cpu        = number
    memory_gb  = number
    storage_gb = number
    min_count  = number
    max_count  = number
  })
}

# Networking
variable "network" { type = string }
variable "subnetwork" { type = string }
variable "composer_internal_ipv4_cidr_block" { type = string }
variable "enable_ip_masq_agent" { type = bool }
variable "tags" { type = list(string) }

variable "resilience_mode" { type = string }
variable "bucket" { type = string }

# Service Account
variable "sa_account_id" { type = string }
variable "sa_display_name" { type = string }

# Roles dinámicos (IMPORTANTE)
variable "composer_roles" {
  type = list(string)
}