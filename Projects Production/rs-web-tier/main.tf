module "buckets" {
  source       = "../../modules/Cloud_Storage"
  for_each     = try(local.buckets,{})
  bucket_name         = each.key
  location     = each.value.location
  storage_class= each.value.storage_class
  project_id = var.project
  kms_key_self_link = "projects/rs-web-tier/locations/us-east4/keyRings/ue4_dlk_prod_kring_kms_001/cryptoKeys/dlk-key-prod001"
  labels            = lookup(each.value, "labels", {})
  storage_bucket_iam_member = lookup(each.value, "iam_roles", {})
}

module "kms_keyrings" {
  source   = "../../modules/key_management"
  for_each = try(local.keyrings,{})

  project_id   = var.project
  location     = each.value.location
  keyring_name = each.key
  keys         = lookup(each.value, "keys", {})
  keyring_iam_members = lookup(each.value, "keyring_iam_members", {})
}

module "network" {
  source = "../../modules/Network"
  for_each = try(local.networks,{})
  network_name            = each.key
  auto_create_subnetworks = each.value.auto_create_subnetworks
  subnets                 = each.value.subnets
}


module "network_router" {
  source       = "../../modules/cloud_router"
  for_each = try(local.routers,{})
  project_id   = var.project
  region       = each.value.region
  network_id   = each.value.network_id
  router_name  = each.key
  asn = each.value.asn_number
}

module "network_nat" {
  source      = "../../modules/cloud_nat"
  for_each = try(local.nats,{})
  project_id  = var.project
  region      = each.value.region
  router_name = each.value.router_name
  nat_name    = each.key
  subnetworks = lookup(each.value, "subnetworks", [])
  source_subnetwork_ip_ranges_to_nat = each.value.source_subnetwork_ip_ranges_to_nat
}

module "shared_vpc_access" {
  source   = "../../modules/shared_vpc"
  
  for_each = try(local.shared_config.compartir_redes,{})
  
  # 1. host_project_id recibe el ID del proyecto actual (rs-web-tier)
  host_project_id     = var.project 
  
  # 2. service_project_id recibe "rs-app-tier-1" del JSON
  service_project_id  = each.value.proyecto_invitado
  
  # 3. service_project_num recibe "906041062473" del JSON
  # IMPORTANTE: El nombre a la izquierda DEBE existir en variables.tf del módulo
  service_project_num = each.value.proyecto_numero 
  
  # 4. region recibe "us-central1" del JSON
  region              = each.value.region
  
  # 5. subnet_name recibe "uc1-subnetwork-prod-001" del JSON
  subnet_name         = each.value.subnet
}

module "firewall" {
  source   = "../../modules/firewall"
  for_each = try(local.firewall_config.firewall_rules,{})

  network_name = each.key    # Ejemplo: "uc1-network-prod-001"
  rules        = each.value  # Pasa el MAPA de reglas de esa red
}

module "vpc_routes" {
  source     = "../../modules/vpc_routes"
  # Asegúrate que este JSON tenga campos de RUTAS, no de Shared VPC
  routes = local.routes
}


