variable "location" { 
  type    = string
  default = "us-central1" 
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

variable "subnets" {
  description = "Subnets map"
  type = map(object({
    ip_cidr_range = string
    secondary_ip_ranges = map(string)
  }))
}

