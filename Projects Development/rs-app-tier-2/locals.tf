locals {
  buckets = jsondecode(file("${path.module}/config/buckets.json"))
}