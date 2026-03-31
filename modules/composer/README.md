# Módulo composer

## Descripción
Crea un entorno de Google Cloud Composer (Airflow gestionado) con configuración avanzada de red, mantenimiento y recursos.


## Entradas (inputs)

| Nombre                      | Tipo    | Obligatorio | Descripción                                         |
|-----------------------------|---------|-------------|-----------------------------------------------------|
| `name`                      | string  | Sí          | Nombre del entorno Composer.                        |
| `region`                    | string  | Sí          | Región.                                             |
| `project`                   | string  | Sí          | ID del proyecto.                                    |
| `enable_private_builds_only`| bool    | Sí          | Solo builds privados.                               |
| `enable_private_environment`| bool    | Sí          | Habilita entorno privado.                           |
| `environment_size`          | string  | Sí          | Tamaño del entorno.                                 |
| `retention_mode`            | string  | Sí          | Modo de retención de datos.                         |
| `maintenance_start_time`    | string  | Sí          | Hora de inicio de mantenimiento.                    |
| `maintenance_end_time`      | string  | Sí          | Hora de fin de mantenimiento.                       |
| `maintenance_recurrence`    | string  | Sí          | Recurrencia de mantenimiento.                       |
| `image_version`             | string  | Sí          | Versión de imagen de Composer.                      |
| `env_variables`             | map     | Sí          | Variables de entorno.                               |
| `pypi_packages`             | map     | Sí          | Paquetes PyPI.                                      |
| `web_server_plugins_mode`   | string  | Sí          | Modo de plugins del web server.                     |
| `data_lineage_enabled`      | bool    | Sí          | Habilita data lineage.                              |
| `allowed_ip_ranges`         | list    | Sí          | Rangos de IP permitidos.                            |
| `scheduler`                 | object  | Sí          | Configuración del scheduler.                        |
| `triggerer`                 | object  | Sí          | Configuración del triggerer.                        |
| `dag_processor`             | object  | Sí          | Configuración del dag_processor.                    |
| `web_server`                | object  | Sí          | Configuración del web_server.                       |


## Ejemplo de uso
```hcl
module "composer" {
  source = "./modules/composer"
  name   = "composer-example"
  region = var.region
  project = var.project_id
  # ...otros parámetros obligatorios...
}
```

## Versiones
- Provider: `google` ~> 7.20
- Compatible con Terraform 1.x

---
Consulta el README general para más detalles del flujo GitOps.