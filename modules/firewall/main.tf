resource "google_compute_firewall" "rules" {
  for_each = var.firewall_rules

  name        = each.key
  project     = var.project_id
  network     = var.network
  description = try(each.value.description, null)

  direction = each.value.direction
  priority  = try(each.value.priority, 1000)

  source_ranges      = each.value.direction == "INGRESS" ? try(each.value.ranges, []) : null
  destination_ranges = each.value.direction == "EGRESS" ? try(each.value.ranges, []) : null

  target_tags = try(each.value.target_tags, null)

  # 🔥 FIX AQUÍ
  dynamic "allow" {
    for_each = try(each.value.allow != null ? each.value.allow : [], [])
    content {
      protocol = allow.value.protocol
      ports    = try(allow.value.ports, null)
    }
  }

  # 🔥 FIX AQUÍ
  dynamic "deny" {
    for_each = try(each.value.deny != null ? each.value.deny : [], [])
    content {
      protocol = deny.value.protocol
      ports    = try(deny.value.ports, null)
    }
  }
}