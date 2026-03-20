variable "project_id" {
  type = string
}

variable "region" {
  type    = string
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

# NAT behavior
variable "nat_ip_allocate_option" {
  type        = string
  description = "AUTO_ONLY o MANUAL_ONLY"
  default     = "AUTO_ONLY"
}

variable "source_subnetwork_ip_ranges_to_nat" {
  type        = string
  description = "ALL_SUBNETWORKS_ALL_IP_RANGES o LIST_OF_SUBNETWORKS"
  default     = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}

# Logging
variable "enable_logging" {
  type        = bool
  description = "Habilitar logs de NAT"
  default     = false
}

variable "log_filter" {
  type        = string
  description = "ERRORS_ONLY, TRANSLATIONS_ONLY, ALL"
  default     = "ERRORS_ONLY"
}

# Subnetworks (modo granular)
variable "subnetworks" {
  description = "Lista de subredes para NAT granular"
  type = list(object({
    name                     = string
    source_ip_ranges_to_nat  = list(string)
    secondary_ip_range_names = optional(list(string))
  }))
  default = []
}

# Timeouts
variable "tcp_established_idle_timeout_sec" {
  type    = number
  default = 1200
}

variable "tcp_transitory_idle_timeout_sec" {
  type    = number
  default = 30
}