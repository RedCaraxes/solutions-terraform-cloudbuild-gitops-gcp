locals {
  buckets = jsondecode(file("${path.module}/config/buckets.json"))
}

locals {
  networks = try(jsondecode(file("${path.module}/config/networks.json")),{})
}