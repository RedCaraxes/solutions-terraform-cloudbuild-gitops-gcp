#!/bin/bash
set -e

# 1. Validar argumentos
if [ "$#" -ne 2 ]; then
  echo "Uso: sh tag-push.sh <accion#projectid> <ticket>"
  exit 1
fi

TAG_INFO="$1" 
TICKET="$2"   # <--- Recuperamos el ticket
PROJECT_ID=$(echo "$TAG_INFO" | cut -d'#' -f2)
DATE=$(date +"%Y%m%d%H%M")
# El tag final mantiene toda la info: accion#project#ticket#fecha
FULL_TAG="${TAG_INFO}#${TICKET}#${DATE}"

# 2. Localizar ambiente y carpeta
POSIBLES_AMBIENTES=("Projects" "Security" "Networking")
TARGET_DIR=""
AMBIENTE_DETECTADO="Raíz (Desconocido)"

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
    echo "ERROR: No existe la carpeta para '$PROJECT_ID' en Projects, Security o Networking."
    exit 1
fi

# 3. Resumen y Confirmación
echo "========================================================="
echo "        RESUMEN DE DESPLIEGUE"
echo "========================================================="
echo " AMBIENTE:  $AMBIENTE_DETECTADO"
echo " PROYECTO:  $PROJECT_ID"
echo " TICKET:    $TICKET"
echo " RUTA:      $TARGET_DIR"
echo " TAG:       $FULL_TAG"
echo "========================================================="

git add "$TARGET_DIR"
git status --short "$TARGET_DIR"

read -p "¿Confirmas el despliegue para el ticket $TICKET? (s/n): " confirm

if [[ ! "$confirm" =~ ^[Ss]$ ]]; then
    echo "Operación cancelada."
    git reset "$TARGET_DIR"
    exit 0
fi

# 4. Commit y Push selectivo
if git diff --cached --quiet; then
    echo "No hay cambios en archivos. Solo se subirá el Tag."
else
    git commit -m "Deploy $TICKET: $PROJECT_ID ($AMBIENTE_DETECTADO)"
    git push origin $(git symbolic-ref --short HEAD)
fi

# 5. Taggear y subir
git tag -a "$FULL_TAG" -m "Ticket: $TICKET"
git push origin --tags

echo "===== Tag $FULL_TAG enviado con éxito ====="