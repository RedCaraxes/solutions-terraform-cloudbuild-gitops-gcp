resource "google_compute_firewall" "rules" {
  for_each = var.rules # Aquí itera sobre "allow-ssh", "allow-internal", etc.

  name    = each.key
  network = var.network_name

  description = lookup(each.value, "description", null)
  direction   = lookup(each.value, "direction", "INGRESS")

  source_ranges      = lookup(each.value, "direction", "INGRESS") == "INGRESS" ? each.value.ranges : null
  destination_ranges = lookup(each.value, "direction", "INGRESS") == "EGRESS" ? each.value.ranges : null
  target_tags        = lookup(each.value, "target_tags", null)

  dynamic "allow" {
    for_each = lookup(each.value, "allow", [])
    content {
      protocol = allow.value.protocol
      ports    = lookup(allow.value, "ports", null)
    }
  }

  dynamic "deny" {
    for_each = lookup(each.value, "deny", [])
    content {
      protocol = deny.value.protocol
      ports    = lookup(deny.value, "ports", null)
    }
  }
}