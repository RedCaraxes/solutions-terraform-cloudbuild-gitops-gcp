variable "name" {
  description = "Nombre del entorno de Composer"
  type        = string
}

variable "region" {
  description = "Región donde se desplegará Composer"
  type        = string
}

variable "project" {
  description = "ID del proyecto GCP"
  type        = string
}

variable "enable_private_builds_only" {
  description = "Habilita builds privados únicamente"
  type        = bool
}

variable "enable_private_environment" {
  description = "Define si el entorno es privado"
  type        = bool
}

variable "environment_size" {
  description = "Tamaño del entorno de Composer"
  type        = string
}

variable "retention_mode" {
  description = "Modo de retención de metadata de Airflow"
  type        = string
}

variable "maintenance_start_time" {
  description = "Inicio de la ventana de mantenimiento (RFC3339)"
  type        = string
}

variable "maintenance_end_time" {
  description = "Fin de la ventana de mantenimiento (RFC3339)"
  type        = string
}

variable "maintenance_recurrence" {
  description = "Recurrencia de mantenimiento en formato RRULE"
  type        = string
}

variable "image_version" {
  description = "Versión de Composer/Airflow"
  type        = string
}

variable "env_variables" {
  description = "Variables de entorno para Airflow"
  type        = map(string)
}

variable "pypi_packages" {
  description = "Paquetes PyPI a instalar"
  type        = map(string)
}

variable "web_server_plugins_mode" {
  description = "Modo de plugins del web server"
  type        = string
}

variable "data_lineage_enabled" {
  description = "Habilita integración con Data Lineage"
  type        = bool
}

variable "allowed_ip_ranges" {
  description = "Lista de rangos IP permitidos para el web server"
  type = list(object({
    value       = string
    description = string
  }))
}

# Workloads

variable "scheduler" {
  description = "Configuración del scheduler"
  type = object({
    cpu        = number
    memory_gb  = number
    storage_gb = number
    count      = number
  })
}

variable "triggerer" {
  description = "Configuración del triggerer"
  type = object({
    cpu       = number
    memory_gb = number
    count     = number
  })
}

variable "dag_processor" {
  description = "Configuración del DAG processor"
  type = object({
    cpu        = number
    memory_gb  = number
    storage_gb = number
    count      = number
  })
}

variable "web_server" {
  description = "Configuración del web server"
  type = object({
    cpu        = number
    memory_gb  = number
    storage_gb = number
  })
}

variable "worker" {
  description = "Configuración de workers"
  type = object({
    cpu        = number
    memory_gb  = number
    storage_gb = number
    min_count  = number
    max_count  = number
  })
}

# Node config

variable "network" {
  description = "VPC network donde se despliega Composer"
  type        = string
}

variable "subnetwork" {
  description = "Subred utilizada por Composer"
  type        = string
}

variable "service_account" {
  description = "Service account usada por Composer"
  type        = string
}

variable "composer_internal_ipv4_cidr_block" {
  description = "CIDR interno para Composer"
  type        = string
}

variable "enable_ip_masq_agent" {
  description = "Habilita IP masquerading"
  type        = bool
}

variable "tags" {
  description = "Tags de red"
  type        = list(string)
}

variable "resilience_mode" {
  description = "Modo de resiliencia del entorno"
  type        = string
}

variable "bucket" {
  description = "Bucket de almacenamiento de Composer"
  type        = string
}

# Service Account

variable "sa_account_id" {
  description = "ID de la service account"
  type        = string
}

variable "sa_display_name" {
  description = "Nombre descriptivo de la service account"
  type        = string
}

variable "composer_worker_role" {
  description = "Rol asignado a la service account de Composer"
  type        = string
}