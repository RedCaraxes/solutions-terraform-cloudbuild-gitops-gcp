#!/bin/bash
set -e

# 1. Validar argumentos
if [ "$#" -lt 2 ]; then
  echo "Uso: sh tag-push.sh <accion#projectid> <ticket> [--all]"
  exit 1
fi

TAG_INFO="$1" 
TICKET="$2"
MODE="$3"

ACCION=$(echo "$TAG_INFO" | cut -d'#' -f1)
PROJECT_ID=$(echo "$TAG_INFO" | cut -d'#' -f2)
DATE=$(date +"%Y%m%d%H%M")
FULL_TAG="${TAG_INFO}#${TICKET}#${DATE}"

# 2. Localizar ambiente y carpeta
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

if [ -z "$TARGET_DIR" ]; then
    echo "ERROR: No existe la carpeta para '$PROJECT_ID'."
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

# --- INSPECCIÓN DE ESTADO PRE-DESPLIEGUE ---
if git diff --cached --quiet; then
    if [ "$ACCION" == "apply" ]; then
        echo ">>> ESTADO: SIN CAMBIOS LOCALES NUEVOS"
        echo ">>> REVISIÓN DE ÚLTIMO COMMIT DISPONIBLE (BASE PARA APPLY):"
        echo "---------------------------------------------------------"
        git log -1 --name-status --oneline || echo "Aviso: No se pudo leer el historial de Git."
    else
        echo ">>> ESTADO: LISTO PARA EJECUTAR PLAN (SIN CAMBIOS PENDIENTES)"
    fi
else
    echo ">>> CAMBIOS DETECTADOS PARA CONFIRMAR Y SUBIR:"
    git status --short
fi
# -------------------------------------------

echo "---------------------------------------------------------"
read -p "¿Confirmas el despliegue con alcance [$SCOPE]? (s/n): " confirm

if [[ ! "$confirm" =~ ^[Ss]$ ]]; then
    echo "Operacion cancelada."
    git reset
    exit 0
fi

# 5. Commit y Push (Con visualización de historial para Apply)
if git diff --cached --quiet; then
    echo "No hay cambios locales nuevos detectados."
    
    if [ "$ACCION" == "apply" ]; then
        echo "---------------------------------------------------------"
        echo ">>> REVISANDO CAMBIOS YA CONFIRMADOS (PLAN ANTERIOR):"
        # El '|| true' evita que el script muera si el log falla
        git log -1 --name-status --oneline || true
        echo "---------------------------------------------------------"
    fi
    echo "Solo se subira el Tag."
else
    echo "Confirmando nuevos cambios locales..."
    git commit -m "Deploy $TICKET: $PROJECT_ID | Modo: ${MODE:-Selective}"
    git push origin $(git symbolic-ref --short HEAD)
fi

# 6. Taggear y subir (ESTO ACTIVA LOS TRIGGERS)
# No mover ni borrar estas líneas
git tag -a "$FULL_TAG" -m "Ticket: $TICKET | Scope: $SCOPE"
git push origin --tags

echo "===== Tag $FULL_TAG enviado con exito ====="