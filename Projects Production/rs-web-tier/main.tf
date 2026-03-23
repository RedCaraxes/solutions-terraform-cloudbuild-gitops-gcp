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
  keys         = lookup(each.value, "keys", {})
  keyring_iam_members = lookup(each.value, "keyring_iam_members", {})
}

module "network" {
  source = "../../modules/Network"
  for_each = local.networks
  network_name            = each.key
  auto_create_subnetworks = each.value.auto_create_subnetworks
  subnets                 = each.value.subnets
}


module "network_router" {
  source       = "../../modules/cloud_router"
  for_each = local.routers
  project_id   = var.project
  region       = each.value.region
  network_id   = each.value.network_id
  router_name  = each.key
  asn = each.value.asn_number
}

module "network_nat" {
  source      = "../../modules/cloud_nat"
  for_each = local.nats
  project_id  = var.project
  region      = each.value.region
  router_name = each.value.router_name
  nat_name    = each.key
  subnetworks = lookup(each.value, "subnetworks", [])
  source_subnetwork_ip_ranges_to_nat = each.value.source_subnetwork_ip_ranges_to_nat
}

resource "google_compute_shared_vpc_host_project" "host" {
  project = var.project
}

module "shared_vpc_access" {
  source   = "../../modules/shared_vpc"
  
  # Una sola declaración que recorre todo el JSON
  for_each = local.shared_config.compartir_redes
  host_project_id    = var.project
  service_project_id = each.value.proyecto_invitado
  region             = each.value.region
  subnet_name        = each.value.subnet
}