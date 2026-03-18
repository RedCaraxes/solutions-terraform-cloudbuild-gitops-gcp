# Copyright 2019 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

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

module "kms_keyrings" {
  source   = "../../modules/key_management"
  for_each = local.keyrings

  project_id   = var.project
  location     = each.value.location
  keyring_name = each.key
  keys         = each.value.keys
}

module "network" {
  source = "../../modules/Network"
  for_each = local.networks
  network_name = each.key
  auto_create_subnetworks = each.value.auto_create_subnetworks
  subnetwork_name = each.value.subnets
  ip_cidr_range = each.value.ip_cidr_range
  secondary_ip_cidr_range = each.value.secondary_ip_cidr_range
  secondary_ip_range_name = each.value.secondary_ip_range_name
}