# Módulo Cloud_Storage

## Descripción
Crea un bucket de Google Cloud Storage con cifrado KMS obligatorio, versionamiento y políticas de ciclo de vida.


## Entradas (inputs)

| Nombre                      | Tipo    | Obligatorio | Descripción                                                                 |
|-----------------------------|---------|-------------|-----------------------------------------------------------------------------|
| `kms_key_self_link`         | string  | Sí          | Self-link de la llave KMS (formato validado).                               |
| `bucket_name`               | string  | Sí          | Nombre del bucket.                                                          |
| `project_id`                | string  | Sí          | ID del proyecto.                                                            |
| `location`                  | string  | No          | Región (default: us-central1).                                              |
| `storage_class`             | string  | No          | Clase de almacenamiento (default: STANDARD).                                |
| `versioning_enabled`        | bool    | No          | Habilita versionamiento (default: false).                                   |
| `soft_delete_retention_time`| number  | No          | Retención de soft delete en segundos (default: 0).                          |
| `labels`                    | map     | No          | Etiquetas (default: {}).                                                    |
| `lifecycle_rules`           | list    | No          | Reglas de ciclo de vida (default: []).                                      |
| `storage_bucket_iam_member` | map     | No          | IAM members (default: {}).                                                  |


## Ejemplo de uso
```hcl
module "cloud_storage" {
  source            = "./modules/Cloud_Storage"
  kms_key_self_link = var.kms_key_self_link
  bucket_name       = "bucket-example"
  project_id        = var.project_id
}
```

## Versiones
- Provider: `google` ~> 7.20
- Compatible con Terraform 1.x

---
Consulta el README general para más detalles del flujo GitOps.