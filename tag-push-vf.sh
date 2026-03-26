#!/bin/bash
set -e

# 1. Validar argumentos
if [ "$#" -lt 2 ]; then
  echo "Uso: sh push.sh <project_id> <ticket> [--all]"
  exit 1
fi

PROJECT_ID="$1"
TICKET="$2"
MODE="$3"

DATE=$(date +"%Y%m%d%H%M")

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

# 3. Definir alcance
if [ "$MODE" == "--all" ]; then
    SCOPE="TODO EL REPOSITORIO (Mantenimiento)"
    git add .
else
    SCOPE="Carpeta del Proyecto ($TARGET_DIR)"
    git add "$TARGET_DIR"
fi

# 4. Resumen
echo "========================================================="
echo "        RESUMEN DE PUSH"
echo "========================================================="
echo " ALCANCE:    $SCOPE"
echo " AMBIENTE:   $AMBIENTE_DETECTADO"
echo " PROYECTO:   $PROJECT_ID"
echo " TICKET:     $TICKET"
echo " BRANCH:     $(git symbolic-ref --short HEAD)"
echo "========================================================="

# --- INSPECCIÓN ---
if git diff --cached --quiet; then
    echo ">>> ESTADO: SIN CAMBIOS NUEVOS"
    echo ">>> Último commit:"
    git log -1 --name-status --oneline || true
else
    echo ">>> CAMBIOS DETECTADOS:"
    git status --short
fi
# -----------------

echo "---------------------------------------------------------"
read -p "¿Confirmas el push [$SCOPE]? (s/n): " confirm

if [[ ! "$confirm" =~ ^[Ss]$ ]]; then
    echo "Operacion cancelada."
    git reset
    exit 0
fi

# 5. Commit y Push
if git diff --cached --quiet; then
    echo "No hay cambios nuevos, no se hará commit."
else
    echo "Confirmando cambios..."
    git commit -m "[$TICKET] Deploy $PROJECT_ID | $(git symbolic-ref --short HEAD)"
fi

echo "Subiendo cambios al remoto..."
git push origin $(git symbolic-ref --short HEAD)

echo "===== Push completado ====="