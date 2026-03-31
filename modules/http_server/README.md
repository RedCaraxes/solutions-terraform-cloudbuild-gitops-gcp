# Módulo http_server

## Descripción
Crea una instancia de VM con Apache2 en GCP, útil para pruebas y entornos de desarrollo.


## Entradas (inputs)

| Nombre    | Tipo   | Obligatorio | Descripción                        |
|-----------|--------|-------------|------------------------------------|
| `project` | string | Sí          | ID del proyecto.                   |
| `subnet`  | string | Sí          | Subred donde desplegar la VM.      |


## Ejemplo de uso
```hcl
module "http_server" {
  source  = "./modules/http_server"
  project = var.project_id
  subnet  = var.subnet
}
```

## Versiones
- Provider: `google` ~> 7.20
- Compatible con Terraform 1.x

---
Consulta el README general para más detalles del flujo GitOps.