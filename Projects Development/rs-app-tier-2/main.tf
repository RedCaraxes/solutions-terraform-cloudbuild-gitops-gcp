module "buckets" {
  source       = "../../modules/Cloud_Storage"
  for_each     = local.buckets
  bucket_name         = each.key
  location     = each.value.location
  storage_class= each.value.storage_class
  project_id = var.project
  kms_key_self_link = "projects/rs-web-tier/locations/us-east4/keyRings/ue4_dlk_prod_kring_kms_001/cryptoKeys/dlk-key-prod001"
  labels            = lookup(each.value, "labels", {})
}

module "network" {
  source = "../../modules/Network"
  for_each = try(local.networks,{})
  network_name            = each.key
  auto_create_subnetworks = each.value.auto_create_subnetworks
  subnets                 = each.value.subnets
}

