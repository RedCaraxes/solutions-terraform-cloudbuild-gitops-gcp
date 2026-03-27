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


module "composer" {
  source = "../../modules/composer"

  name    = "composer-test"
  region  = "us-central1"
  project = "my-project-id"

  enable_private_builds_only = false
  enable_private_environment = true
  environment_size           = "ENVIRONMENT_SIZE_SMALL"

  retention_mode = "RETENTION_MODE_DISABLED"

  maintenance_start_time = "2025-01-01T00:00:00Z"
  maintenance_end_time   = "2025-01-01T04:00:00Z"
  maintenance_recurrence = "FREQ=WEEKLY;BYDAY=SU"

  image_version           = "composer-3-airflow-2.9.3"
  env_variables           = {}
  pypi_packages           = {}
  web_server_plugins_mode = "ENABLED"
  data_lineage_enabled    = false

  allowed_ip_ranges = [
    {
      value       = "0.0.0.0/0"
      description = "test"
    }
  ]

  scheduler = {
    cpu = 0.5
    memory_gb = 2
    storage_gb = 1
    count = 1
  }

  triggerer = {
    cpu = 0.5
    memory_gb = 1
    count = 1
  }

  dag_processor = {
    cpu = 0.5
    memory_gb = 2
    storage_gb = 1
    count = 1
  }

  web_server = {
    cpu = 0.5
    memory_gb = 2
    storage_gb = 1
  }

  worker = {
    cpu = 0.5
    memory_gb = 2
    storage_gb = 1
    min_count = 1
    max_count = 1
  }

  network    = "projects/rs-web-tier/global/networks/uc1-orgnet-prd-net-dev-vpc-001"
  subnetwork = "projects/rs-web-tier/regions/us-central1/subnetworks/uc1-orgnet-prd-net-dev-sbn-002"

  composer_internal_ipv4_cidr_block = "100.64.0.0/20"
  enable_ip_masq_agent              = false
  tags                              = []

  resilience_mode = "STANDARD_RESILIENCE"

  bucket = "composer-bucket-test-123"

  sa_account_id   = "composer-sa-test"
  sa_display_name = "Composer Test SA"

  composer_roles = [
    "roles/composer.worker"
  ]
}