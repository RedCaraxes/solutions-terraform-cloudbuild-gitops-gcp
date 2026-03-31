# Módulo firewall

## Descripción
Crea reglas de firewall en una VPC de GCP a partir de un mapa de reglas (usualmente extraídas de un JSON).


## Entradas (inputs)

| Nombre         | Tipo   | Obligatorio | Descripción                        |
|--------------- |--------|-------------|------------------------------------|
| `network_name` | string | Sí          | Nombre de la red VPC.              |
| `rules`        | any    | Sí          | Mapa de reglas de firewall.        |


## Ejemplo de uso
```hcl
module "firewall" {
  source       = "./modules/firewall"
  network_name = var.network_name
  rules        = var.rules
}
```

## Versiones
- Provider: `google` ~> 7.20
- Compatible con Terraform 1.x

---
Consulta el README general para más detalles del flujo GitOps.