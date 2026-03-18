variable "subnetwork_name" {
  description = "name of subnet"
  type = string
}

variable "ip_cidr_range" {
  description = "Ip CIDR range"
  type = string
}

variable "location" { 
  type    = string
  default = "US-EAST1" 
}

variable "secondary_ip_range_name" {
  description = "ip secondary range"
  type = string
}

variable "secondary_ip_cidr_range" {
  description = "ip cidr range"
  type = string
}

variable "network_name" {
    description = "Network Name"
    type = string
}

variable "auto_create_subnetworks" {
  description = "automatic creation on subnetworks"
  type = bool
  default = false
}

