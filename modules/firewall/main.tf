resource "google_compute_firewall" "rules" {
  for_each = var.rules

  name        = each.key
  network     = var.network_name
  description = lookup(each.value, "description", null)
  direction   = lookup(each.value, "direction", "INGRESS")
  target_tags = lookup(each.value, "target_tags", null)

  # Si es INGRESS usa source_ranges, si es EGRESS usa destination_ranges
  source_ranges      = each.value.direction == "INGRESS" ? each.value.ranges : null
  destination_ranges = each.value.direction == "EGRESS" ? each.value.ranges : null

  # Bloque dinámico para "allow"
  dynamic "allow" {
    for_each = lookup(each.value, "allow", [])
    content {
      protocol = allow.value.protocol
      ports    = lookup(allow.value, "ports", null)
    }
  }

  # Bloque dinámico para "deny"
  dynamic "deny" {
    for_each = lookup(each.value, "deny", [])
    content {
      protocol = deny.value.protocol
      ports    = lookup(deny.value, "ports", null)
    }
  }
}