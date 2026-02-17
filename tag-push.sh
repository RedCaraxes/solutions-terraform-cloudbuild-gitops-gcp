#!/bin/bash
set -e

if [ "$#" -ne 2 ]; then
  echo "Uso: sh tag-push.sh <accion#projectid> <ticket>"
  exit 1
fi

TAG_INFO="$1" # Ejemplo: plan#rs-prd-dlk
TICKET="$2"
DATE=$(date +"%Y%m%d%H%M")
FULL_TAG="${TAG_INFO}#${TICKET}#${DATE}"

# 1. Commit automático de lo que esté pendiente
git add .
git commit -m "Deploy: $FULL_TAG" || echo "No hay cambios para commit"

# 2. Crear y subir Tag
git tag -a "$FULL_TAG" -m "Ticket: $TICKET"
git push origin $(git symbolic-ref --short HEAD) --tags

echo "===== Tag $FULL_TAG enviado ====="