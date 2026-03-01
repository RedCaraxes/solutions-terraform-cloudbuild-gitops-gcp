locals {
  buckets = jsondecode(file("${path.module}/00_config/core/buckets.json"))
}