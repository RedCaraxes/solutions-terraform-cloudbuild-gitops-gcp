variable "project_id" {
  type        = string
  description = "ID del proyecto Host de la Shared VPC"
}

variable "region" {
  type        = string
  default     = "us-central1"
  description = "Región donde residirá el router"
}

variable "network_id" {
  type        = string
  description = "ID o Self-link de la VPC creada en el módulo anterior"
}

variable "router_name" {
  type        = string
  description = "Nombre del Cloud Router"
}

variable "asn" {
  type        = number
  description = "Local ASN para BGP (64512-65534)"
}