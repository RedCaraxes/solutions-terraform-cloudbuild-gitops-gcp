#!/bin/bash
set -e

# 1. Validar argumentos
if [ "$#" -lt 2 ]; then
  echo "Uso: sh tag-push.sh <project_id> <ticket> [--all]"
  exit 1
fi

PROJECT_ID="$1"
TICKET="$2"
MODE="$3"

DATE=$(date +"%Y%m%d%H%M")
FULL_TAG="${PROJECT_ID}#${TICKET}#${DATE}"

# 🚨 Bloqueo en main (seguridad)
CURRENT_BRANCH=$(git symbolic-ref --short HEAD)
if [ "$CURRENT_BRANCH" == "main" ]; then
  echo "❌ ERROR: No debes ejecutar este script en main"
  exit 1
fi

# 2. Localizar ambiente y carpeta
POSIBLES_AMBIENTES=("Projects Production" "Projects Development" "Projects Networking" "Projects Security y Organizations")
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

# 3. Definir archivos
if [ "$MODE" == "--all" ]; then
    SCOPE="TODO EL REPOSITORIO (Mantenimiento)"
    git add .
else
    SCOPE="Carpeta del Proyecto ($TARGET_DIR)"
    git add "$TARGET_DIR"
fi

# 4. Resumen
echo "========================================================="
echo "        RESUMEN DE DESPLIEGUE"
echo "========================================================="
echo " RAMA:       $CURRENT_BRANCH"
echo " ALCANCE:    $SCOPE"
echo " AMBIENTE:   $AMBIENTE_DETECTADO"
echo " PROYECTO:   $PROJECT_ID"
echo " TICKET:     $TICKET"
echo " TAG:        $FULL_TAG"
echo "========================================================="

# Estado
if git diff --cached --quiet; then
    echo ">>> SIN CAMBIOS LOCALES NUEVOS"
else
    echo ">>> CAMBIOS DETECTADOS:"
    git status --short
fi

echo "---------------------------------------------------------"
read -p "¿Confirmas el despliegue? (s/n): " confirm

if [[ ! "$confirm" =~ ^[Ss]$ ]]; then
    echo "Operacion cancelada."
    git reset
    exit 0
fi

# 5. Commit y Push
if git diff --cached --quiet; then
    echo "No hay cambios nuevos, solo se subira el tag."
else
    echo "Confirmando cambios..."
    git commit -m "Deploy $TICKET: $PROJECT_ID | Branch: $CURRENT_BRANCH"
    git push origin "$CURRENT_BRANCH"
fi

# 6. Tag (🔥 sigue siendo tu trigger)
git tag -a "$FULL_TAG" -m "Ticket: $TICKET | Scope: $SCOPE"
git push origin --tags

echo "===== Tag $FULL_TAG enviado con exito ====="