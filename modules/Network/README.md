# Módulo Network

## Descripción
Crea una red VPC y subredes en GCP, con soporte para subredes secundarias.


## Entradas (inputs)

| Nombre                   | Tipo   | Obligatorio | Descripción                                         |
|--------------------------|--------|-------------|-----------------------------------------------------|
| `network_name`           | string | Sí          | Nombre de la red VPC.                               |
| `subnets`                | map    | Sí          | Mapa de subredes a crear.                           |
| `location`               | string | No          | Región (default: us-central1).                      |
| `auto_create_subnetworks`| bool   | No          | Crea subredes automáticas (default: false).         |


## Ejemplo de uso
```hcl
module "network" {
  source                  = "./modules/Network"
  network_name            = "vpc-example"
  subnets                 = var.subnets
  auto_create_subnetworks = false
}
```

## Versiones
- Provider: `google` ~> 7.20
- Compatible con Terraform 1.x

---
Consulta el README general para más detalles del flujo GitOps.