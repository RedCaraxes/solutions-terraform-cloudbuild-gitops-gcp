# Módulo key_management

## Descripción
Crea un KeyRing y llaves KMS en GCP, con soporte para rotación y asignación de IAM members.


## Entradas (inputs)

| Nombre                | Tipo    | Obligatorio | Descripción                                                                 |
|-----------------------|---------|-------------|-----------------------------------------------------------------------------|
| `project_id`          | string  | Sí          | ID del proyecto donde se crean los recursos KMS.                            |
| `location`            | string  | Sí          | Ubicación del KeyRing.                                                      |
| `keyring_name`        | string  | Sí          | Nombre del KeyRing de KMS.                                                  |
| `keys`                | map     | Sí          | Mapa de llaves a crear (con propósito, rotación, labels).                   |
| `keyring_iam_members` | map     | No          | IAM members para el KeyRing (por defecto: `{}`).                             |



## Ejemplo de uso
```hcl
module "key_management" {
  source       = "./modules/key_management"
  project_id   = var.project_id
  location     = var.location
  keyring_name = "keyring-example"
  keys         = var.keys
}
```

## Versiones
- Provider: `google` ~> 7.20
- Compatible con Terraform 1.x

---
Consulta el README general para más detalles del flujo GitOps.