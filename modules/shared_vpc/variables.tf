variable "host_project_id"    { type = string } # Proyecto A (Dueño)
variable "service_project_id" { type = string } # Proyecto B (Invitado)
variable "region"             { type = string } # Ejemplo: us-central1
variable "subnet_name"        { type = string } # Nombre de la subred a compartir