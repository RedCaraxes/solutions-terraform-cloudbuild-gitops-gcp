locals {
  buckets = jsondecode(file("${path.module}/buckets.json"))
}