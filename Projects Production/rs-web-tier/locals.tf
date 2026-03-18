locals {
  buckets = jsondecode(file("${path.module}/config/buckets.json"))
}

locals {
  keyrings = jsondecode(file("${path.module}/config/keyrings.json"))
}