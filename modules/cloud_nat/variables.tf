variable "project_id" {
  type        = string
}

variable "region" {
  type        = string
  default = "us-central1"
}

variable "router_name" {
  type        = string
  description = "Nombre del router al que se asociará este NAT"
}

variable "nat_name" {
  type        = string
  description = "Nombre único para el recurso NAT"
}

variable "log_filter" {
  type        = string
  default     = "ERRORS_ONLY"
  description = "Opciones: ERRORS_ONLY, TRANSLATIONS_ONLY, ALL"
}

variable "labels" {
  type        = map(string)
  description = "Etiquetas para el recurso NAT"
  default     = {
    env      = "prod"
    managed_by = "terraform"
  }
}