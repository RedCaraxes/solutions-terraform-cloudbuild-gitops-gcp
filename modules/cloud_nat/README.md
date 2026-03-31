# Módulo cloud_nat

## Descripción
Crea un recurso Google Cloud NAT asociado a un Cloud Router para permitir la salida a internet de recursos privados en una VPC.


## Entradas (inputs)

| Nombre                              | Tipo   | Obligatorio | Descripción                                                                 |
|------------------------------------- |--------|-------------|-----------------------------------------------------------------------------|
| `project_id`                        | string | Sí          | ID del proyecto GCP.                                                        |
| `router_name`                       | string | Sí          | Nombre del router asociado.                                                  |
| `nat_name`                          | string | Sí          | Nombre único para el recurso NAT.                                            |
| `region`                            | string | No          | Región (default: us-central1).                                               |
| `log_filter`                        | string | No          | Nivel de logs: ERRORS_ONLY, TRANSLATIONS_ONLY, ALL (default: ERRORS_ONLY).  |
| `nat_ip_allocate_option`            | string | No          | AUTO_ONLY o MANUAL_ONLY (default: AUTO_ONLY).                                |
| `source_subnetwork_ip_ranges_to_nat`| string | No          | ALL_SUBNETWORKS_ALL_IP_RANGES o LIST_OF_SUBNETWORKS (default: ALL_SUBNETWORKS_ALL_IP_RANGES). |
| `enable_logging`                    | bool   | No          | Habilita logs (default: false).                                              |
| `subnetworks`                       | list   | No          | Subredes a incluir (default: []).                                            |
| `tcp_established_idle_timeout_sec`  | number | No          | Timeout TCP establecido (default: 1200).                                     |
| `tcp_transitory_idle_timeout_sec`   | number | No          | Timeout TCP transitorio (default: 30).                                       |


## Ejemplo de uso
```hcl
module "cloud_nat" {
  source     = "./modules/cloud_nat"
  project_id = var.project_id
  router_name = var.router_name
  nat_name   = "nat-example"
}
```

## Versiones
- Provider: `google` ~> 7.20
- Compatible con Terraform 1.x

---
Consulta el README general para más detalles del flujo GitOps.