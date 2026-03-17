resource "google_storage_bucket" "bucket" {
  name     = var.bucket_name
  location = var.location
  project  = var.project_id

  storage_class               = var.storage_class
  uniform_bucket_level_access = true
  public_access_prevention    = "enforced"
  labels                      = var.labels

  versioning {
    enabled = var.versioning_enabled
  }

  soft_delete_policy {
    retention_duration_seconds = var.soft_delete_retention_time
  }

  # Bloque estático: Ahora es OBLIGATORIO
  encryption {
    default_kms_key_name = var.kms_key_self_link
  }

  # Ciclo de vida (opcional según lo que envíes en la lista)
  dynamic "lifecycle_rule" {
    for_each = var.lifecycle_rules
    content {
      action {
        type = lifecycle_rule.value.action_type
      }
      condition {
        age = lifecycle_rule.value.condition_age
      }
    }
  }

  lifecycle {
    ignore_changes = [
      labels,
    ]
  }
}