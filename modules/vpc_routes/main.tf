resource "google_compute_route" "route" {
  for_each = var.routes

  network     = each.value.network
  name        = each.key
  description = lookup(each.value, "description", "Ruta gestionada por Terraform")
  dest_range  = each.value.dest_range
  priority    = lookup(each.value, "priority", 1000)
  tags        = lookup(each.value, "tags", null)

  # --- Definición del Siguiente Salto (Next Hop) ---
  # Solo uno de estos debe estar definido por ruta en el JSON.

  # 1. "Puerta de enlace de Internet predeterminada"
  next_hop_gateway = lookup(each.value, "next_hop_gateway", null)

  # 2. "Especificar una instancia" (por nombre)
  next_hop_instance = lookup(each.value, "next_hop_instance", null)

  # 3. "Especificar la dirección IP de una instancia"
  next_hop_ip = lookup(each.value, "next_hop_ip", null)

  # 4. "Especificar túnel VPN"
  next_hop_vpn_tunnel = lookup(each.value, "next_hop_vpn_tunnel", null) # <-- NUEVO

  # 5. "Especifica una regla de reenvío del balanceador de cargas..."
  # (Soporta ILB con Network Virtual Appliances)
  next_hop_ilb = lookup(each.value, "next_hop_ilb", null) # <-- NUEVO
}