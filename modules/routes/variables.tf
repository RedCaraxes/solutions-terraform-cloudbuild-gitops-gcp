variable "routes" {
  type = map(object({
    network             = string
    dest_range          = string
    priority            = optional(number)
    description         = optional(string)
    tags                = optional(list(string))
    
    # Opciones de Siguiente Salto (Next Hop)
    next_hop_gateway    = optional(string)
    next_hop_instance   = optional(string)
    next_hop_ip         = optional(string)
    next_hop_vpn_tunnel = optional(string)
    next_hop_ilb        = optional(string)
  }))
  description = "Mapa de rutas a crear con todos los tipos de salto soportados."
}