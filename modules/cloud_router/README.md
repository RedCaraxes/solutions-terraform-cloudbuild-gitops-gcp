# Módulo cloud_router

## Descripción
Crea un recurso Google Cloud Router para gestionar rutas dinámicas y BGP en una VPC.


## Entradas (inputs)

| Nombre         | Tipo   | Obligatorio | Descripción                                         |
|--------------- |--------|-------------|-----------------------------------------------------|
| `project_id`   | string | Sí          | ID del proyecto host de la VPC.                     |
| `network_id`   | string | Sí          | ID o self-link de la VPC.                           |
| `router_name`  | string | Sí          | Nombre del Cloud Router.                            |
| `asn`          | number | Sí          | ASN local para BGP (64512-65534).                   |
| `region`       | string | No          | Región donde residirá el router (default: us-central1). |


## Ejemplo de uso
```hcl
module "cloud_router" {
  source      = "./modules/cloud_router"
  project_id  = var.project_id
  network_id  = var.network_id
  router_name = "router-example"
  asn         = 64514
}
```

## Versiones
- Provider: `google` ~> 7.20
- Compatible con Terraform 1.x

---
Consulta el README general para más detalles del flujo GitOps.