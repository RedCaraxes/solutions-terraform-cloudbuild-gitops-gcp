resource "google_kms_key_ring" "keyring" {
  name     = var.keyring_name
  location = var.location
  project  = var.project_id
}

resource "google_kms_crypto_key" "keys" {
  for_each = var.keys

  name            = each.key
  key_ring        = google_kms_key_ring.keyring.id
  purpose         = each.value.purpose
  rotation_period = try(each.value.rotation_period, null)
  labels          = try(each.value.labels, {})

  lifecycle {
    prevent_destroy = true
  }
}

resource "google_kms_key_ring_iam_member" "key_ring" {
  for_each = var.keyring_iam_members

  key_ring_id = google_kms_key_ring.keyring.id
  role        = each.value.role
  member      = each.value.member
}

