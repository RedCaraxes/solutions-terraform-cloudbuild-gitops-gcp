# Módulo shared_vpc

## Descripción
Asocia un proyecto de servicio a un proyecto host de Shared VPC y otorga permisos de red necesarios.


## Entradas (inputs)

| Nombre                | Tipo   | Obligatorio | Descripción                                         |
|-----------------------|--------|-------------|-----------------------------------------------------|
| `host_project_id`     | string | Sí          | ID del proyecto host.                               |
| `service_project_id`  | string | Sí          | ID del proyecto invitado.                           |
| `service_project_num` | string | Sí          | Número del proyecto invitado.                       |
| `region`              | string | Sí          | Región de la subred.                                |
| `subnet_name`         | string | Sí          | Nombre de la subred.                                |


## Ejemplo de uso
```hcl
module "shared_vpc" {
  source              = "./modules/shared_vpc"
  host_project_id     = var.host_project_id
  service_project_id  = var.service_project_id
  service_project_num = var.service_project_num
  region              = var.region
  subnet_name         = var.subnet_name
}
```

## Versiones
- Provider: `google` ~> 7.20
- Compatible con Terraform 1.x

---
Consulta el README general para más detalles del flujo GitOps.