# Módulo vpc_routes

## Descripción
Crea rutas personalizadas en una VPC de GCP, soportando todos los tipos de siguiente salto.


## Entradas (inputs)

| Nombre   | Tipo | Obligatorio | Descripción                                                        |
|----------|------|-------------|--------------------------------------------------------------------|
| `routes` | map  | Sí          | Mapa de rutas a crear, cada una con sus atributos y tipo de salto. |


## Ejemplo de uso
```hcl
module "vpc_routes" {
  source = "./modules/vpc_routes"
  routes = var.routes
}
```

## Versiones
- Provider: `google` ~> 7.20
- Compatible con Terraform 1.x

---
Consulta el README general para más detalles del flujo GitOps.