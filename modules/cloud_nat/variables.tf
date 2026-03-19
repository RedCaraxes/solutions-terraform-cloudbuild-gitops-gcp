variable "project_id" {
  type        = string
}

variable "region" {
  type        = string
  default = "US-EAST1"
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