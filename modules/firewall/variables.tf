variable "project_id" {
  description = "ID del proyecto"
  type        = string
}

variable "network" {
  description = "Nombre de la VPC"
  type        = string
}

variable "firewall_rules" {
  type = map(object({
    description  = optional(string)
    direction    = string
    priority     = optional(number)
    ranges       = optional(list(string))
    target_tags  = optional(list(string))
    allow        = optional(list(object({
      protocol = string
      ports    = optional(list(string))
    })))
    deny = optional(list(object({
      protocol = string
      ports    = optional(list(string))
    })))
  }))
}