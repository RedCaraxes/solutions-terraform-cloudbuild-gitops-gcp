# Módulo vpc

## Descripción
Crea una VPC y subredes usando el módulo oficial de Google para redes, soportando ambientes y rangos secundarios.


## Entradas (inputs)

| Nombre    | Tipo   | Obligatorio | Descripción                        |
|-----------|--------|-------------|------------------------------------|
| `project` | string | Sí          | ID del proyecto.                   |
| `env`     | string | Sí          | Nombre del entorno (dev, prod, etc.). |


## Ejemplo de uso
```hcl
module "vpc" {
  source  = "./modules/vpc"
  project = var.project_id
  env     = "dev"
}
```

## Versiones
- Provider: `google` ~> 7.20
- Módulo: terraform-google-modules/network/google 16.0.0
- Compatible con Terraform 1.x

---
Consulta el README general para más detalles del flujo GitOps.