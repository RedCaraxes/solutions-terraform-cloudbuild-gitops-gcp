output "firewall_rules" {
  value = {
    for k, v in google_compute_firewall.rules :
    k => v.self_link
  }
}