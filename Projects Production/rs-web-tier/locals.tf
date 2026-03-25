locals {
  buckets = try(jsondecode(file("${path.module}/config/buckets.json")),{})
}

locals {
  keyrings = try(jsondecode(file("${path.module}/config/keyrings.json")),{})
}

locals {
  networks = try(jsondecode(file("${path.module}/config/networks.json")),{})
}

locals {
  routers = try(jsondecode(file("${path.module}/config/routers.json")),{})
}

locals {
  nats = try(jsondecode(file("${path.module}/config/nats.json")), {})
}

locals {
  shared_config = try(jsondecode(file("${path.module}/config/shared_vpc.json")),{})
}

locals {
  firewall_config = try(jsondecode(file("${path.module}/config/firewall.json")),{})
}

locals {
  routes = try(jsondecode(file("${path.module}/config/routes.json")),{})
}

locals {
  composer_data = try(jsondecode(file("${path.module}/composer_envs.json")),{})
}