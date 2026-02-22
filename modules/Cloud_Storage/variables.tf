variable "kms_key_self_link" {
  description = "El ID de la llave de KMS. Este valor es obligatorio por política de seguridad."
  type        = string
  # Al NO tener 'default', Terraform obligará al usuario a proporcionarlo.

  validation {
    condition     = can(regex("^projects/.+/locations/.+/keyRings/.+/cryptoKeys/.+$", var.kms_key_self_link))
    error_message = "La llave KMS debe tener un formato válido: projects/[PROJECT]/locations/[LOCATION]/keyRings/[RING]/cryptoKeys/[KEY]."
  }
}

variable "bucket_name"   { type = string }
variable "project_id"    { type = string }

variable "location" { 
  type    = string
  default = "US-EAST1" 
}

variable "storage_class" { 
  type    = string
  default = "STANDARD" 
}

variable "lifecycle_rules" {
  type = list(object({
    action_type   = string
    condition_age = number
  }))
  default = []
}