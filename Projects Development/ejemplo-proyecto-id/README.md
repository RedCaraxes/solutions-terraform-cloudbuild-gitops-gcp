# Ejemplo de Proyecto - Projects Development

Esta carpeta es un ejemplo de cómo crear un nuevo proyecto dentro del grupo **Projects Development**.

## Estructura recomendada
- backend.tf
- main.tf
- outputs.tf
- provider.tf
- terraform.tfvars
- variables.tf
- versions.tf
- config/ (opcional, para archivos JSON de configuración)

## ¿Cómo crear un nuevo proyecto?
1. Copia esta carpeta y renómbrala con el ID de tu proyecto.
2. Ajusta los archivos Terraform según las necesidades del nuevo proyecto.
3. Si requieres configuraciones específicas (buckets, firewalls, etc.), agrégalas en la subcarpeta `config/` en formato JSON.

## Integración con el flujo GitOps
- Los cambios en esta carpeta pueden ser versionados y desplegados usando los scripts `tag-push.sh` o `tag-push-vf.sh` desde la raíz del repositorio.
- El nombre de la carpeta debe coincidir con el ID del proyecto para que los scripts lo detecten correctamente.

## Ejemplo de uso de script:
```sh
sh tag-push.sh apply#ejemplo-proyecto-id TICKET-123
```

Esto creará un tag y subirá los cambios del proyecto específico.

---
Para más detalles, consulta el README general del repositorio.