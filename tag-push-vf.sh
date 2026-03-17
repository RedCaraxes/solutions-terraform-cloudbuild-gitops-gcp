#!/bin/bash
set -e

# 1. Validar argumentos
if [ "$#" -lt 2 ]; then
  echo "Uso: sh tag-push.sh <accion#projectid> <ticket> [--all]"
  exit 1
fi

TAG_INFO="$1" 
TICKET="$2"
MODE="$3" # Captura el tercer argumento si existe

ACCION=$(echo "$TAG_INFO" | cut -d'#' -f1)
PROJECT_ID=$(echo "$TAG_INFO" | cut -d'#' -f2)
DATE=$(date +"%Y%m%d%H%M")
FULL_TAG="${TAG_INFO}#${TICKET}#${DATE}"

# 2. Localizar ambiente y carpeta (solo para el resumen, a menos que sea --all)
POSIBLES_AMBIENTES=("Projects" "Security" "Networking")
TARGET_DIR=""
AMBIENTE_DETECTADO="Raiz (Desconocido)"

for amb in "${POSIBLES_AMBIENTES[@]}"; do
    if [ -d "$amb/$PROJECT_ID" ]; then
        TARGET_DIR="$amb/$PROJECT_ID"
        AMBIENTE_DETECTADO="$amb"
        break
    fi
done

if [ -z "$TARGET_DIR" ] && [ -d "$PROJECT_ID" ]; then
    TARGET_DIR="$PROJECT_ID"
fi

# Validar si existe la carpeta (incluso en modo --all, necesitamos un proyecto vaildo para el Tag)
if [ -z "$TARGET_DIR" ]; then
    echo "ERROR: No existe la carpeta para '$PROJECT_ID'. El Tag requiere un proyecto valido."
    exit 1
fi

# 3. Definir que archivos añadir
if [ "$MODE" == "--all" ]; then
    SCOPE="TODO EL REPOSITORIO (Mantenimiento)"
    git add .
else
    SCOPE="Carpeta del Proyecto ($TARGET_DIR)"
    git add "$TARGET_DIR"
fi

# 4. Resumen y Confirmacion
echo "========================================================="
echo "        RESUMEN DE DESPLIEGUE"
echo "========================================================="
echo " OPERACION:  $ACCION"
echo " ALCANCE:    $SCOPE"
echo " AMBIENTE:   $AMBIENTE_DETECTADO"
echo " PROYECTO:   $PROJECT_ID"
echo " TICKET:     $TICKET"
echo " TAG:        $FULL_TAG"
echo "========================================================="

# Mostrar estado de lo que se añadio
git status --short

echo "---------------------------------------------------------"
read -p "¿Confirmas el despliegue con alcance [$SCOPE]? (s/n): " confirm

if [[ ! "$confirm" =~ ^[Ss]$ ]]; then
    echo "Operacion cancelada."
    git reset
    exit 0
fi

# 5. Commit y Push
if git diff --cached --quiet; then
    echo "No hay cambios locales nuevos detectados."
    
    # Solo mostramos info extra si es un apply y no hay cambios nuevos
    if [ "$ACCION" == "apply" ]; then
        echo "---------------------------------------------------------"
        echo ">>> INFO: Verificando cambios del commit anterior (Plan):"
        # Usamos || true para que si falla el log, el script no se detenga (por el set -e)
        git log -1 --name-status --oneline || echo "No se pudo recuperar el historial."
        echo "---------------------------------------------------------"
    fi
    
    echo "Solo se subira el Tag."
else
    echo "Confirmando nuevos cambios locales..."
    git commit -m "Deploy $TICKET: $PROJECT_ID | Modo: ${MODE:-Selective}"
    git push origin $(git symbolic-ref --short HEAD)
fi

# 6. Taggear y subir
git tag -a "$FULL_TAG" -m "Ticket: $TICKET | Scope: $SCOPE"
git push origin --tags

echo "===== Tag $FULL_TAG enviado con exito ====="