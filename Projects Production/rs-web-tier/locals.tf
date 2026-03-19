locals {
  buckets = jsondecode(file("${path.module}/config/buckets.json"))
}

locals {
  keyrings = jsondecode(file("${path.module}/config/keyrings.json"))
}

locals {
  networks = jsondecode(file("${path.module}/config/networks.json"))
}

locals {
  routers = jsondecode(file("${path.module}/config/routers.json"))
}

locals {
  nats = jsondecode(file("${path.module}/config/nats.json"))
}