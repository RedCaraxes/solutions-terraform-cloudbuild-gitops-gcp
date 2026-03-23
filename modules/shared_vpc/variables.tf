variable "host_project_id" {
  type        = string
  description = "ID del proyecto Host"
}

variable "service_project_id" {
  type        = string
  description = "ID del proyecto invitado"
}

# CORRECCIÓN: Se debe llamar igual que en el bloque del módulo (num, no numero)
variable "service_project_num" {
  type        = string
  description = "Número del proyecto invitado para la cuenta de servicio"
}

variable "region" {
  type        = string
  description = "Región de la subred"
}

variable "subnet_name" {
  type        = string
  description = "Nombre de la subred"
}