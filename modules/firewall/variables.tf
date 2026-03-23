variable "network_name" {
  type        = string
  description = "Nombre de la red VPC"
}

variable "rules" {
  type        = any
  description = "Mapa de reglas de firewall extraídas del JSON"
}