variable "project_id" {
  description = "ID del proyecto"
  type        = string
}

variable "network" {
  description = "Nombre de la VPC"
  type        = string
}

variable "firewall_rules" {
  description = "Lista de reglas de firewall"
  type = map(object({
    description   = optional(string)
    direction     = string # INGRESS | EGRESS
    priority      = optional(number, 1000)

    ranges        = optional(list(string)) # source_ranges o destination_ranges
    target_tags   = optional(list(string))
    target_sas    = optional(list(string))

    allow = optional(list(object({
      protocol = string
      ports    = optional(list(string))
    })))

    deny = optional(list(object({
      protocol = string
      ports    = optional(list(string))
    })))
  }))
}