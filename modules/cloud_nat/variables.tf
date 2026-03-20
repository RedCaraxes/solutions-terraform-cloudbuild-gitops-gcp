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

variable "nat_ip_allocate_option" {
  type = string
  default = "AUTO_ONLY"
  description = "Opciones: MANUAL_ONLY, AUTO_ONLY"
}

variable "source_subnetwork_ip_ranges_to_nat" {
  type    = string
  default = "ALL_SUBNETWORKS_ALL_IP_RANGES"
  description = "ALL_SUBNETWORKS_ALL_IP_RANGES o LIST_OF_SUBNETWORKS"
}

# 🔹 Logging
variable "enable_logging" {
  type    = bool
  default = false
}

variable "subnetworks" {
  type = list(object({
    name                     = string
    source_ip_ranges_to_nat  = list(string)
    secondary_ip_range_names = optional(list(string))
  }))
  default = []
}

variable "tcp_established_idle_timeout_sec" {
  type    = number
  default = 1200
}

variable "tcp_transitory_idle_timeout_sec" {
  type    = number
  default = 30
}
