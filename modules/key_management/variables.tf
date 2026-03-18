variable "project_id" {
  description = "Project ID where KMS resources will be created"
  type        = string
}

variable "location" {
  description = "KMS location"
  type        = string
}

variable "keyring_name" {
  description = "Name of the KMS KeyRing"
  type        = string
}

variable "keys" {
  description = "Map of cryptokeys to create in the keyring"

  type = map(object({
    purpose         = optional(string, "ENCRYPT_DECRYPT")
    rotation_period = optional(string)
    labels          = optional(map(string), {})
  }))
}

variable "keyring_iam_members" {
  description = "IAM members for the KMS key ring"
  type = map(object({
    role   = string
    member = string
  }))
  default = {}
}